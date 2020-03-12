using System;
using System.Collections.Generic;
using System.Text;
using WorkManager.Data.ViewModels;

namespace WorkManager.Data.Models.Repositories
{
    public partial interface IGroupsRepository
    {
        #region CREATE
        Groups Convert(CreateGroupViewModel model);
        Groups PrepareCreate(Groups model);
        Groups Create(CreateGroupViewModel model, string createdUserId);
        #endregion

        #region UPDATE
        Groups Edit(Groups entity, EditGroupViewModel editModel);
        #endregion

        #region DELETE
        Groups Delete(Groups entity);
        #endregion
    }
    public partial class GroupsRepository
    {
        #region CREATE
        public Groups Convert(CreateGroupViewModel model)
        {
            return model.ToEntity();
        }
        public Groups PrepareCreate(Groups model)
        {
            model.CreatedTime = DateTime.UtcNow;
            return model;
        }
        public Groups Create(CreateGroupViewModel model, string createdUserId)
        {
            var entity = Convert(model);
            entity = PrepareCreate(entity);

            entity.CreatedUser = createdUserId;
            entity = Create(entity).Entity;
            return entity;
        }
        #endregion

        #region UPDATE
        public Groups Edit(Groups entity, EditGroupViewModel editModel)
        {
            entity.Name = editModel.Name;
            entity.Description = editModel.Description;
            return entity;
        }
        #endregion

        #region DELETE
        public Groups Delete(Groups entity)
        {
            return Remove(entity).Entity;
        }
        #endregion
    }
}
