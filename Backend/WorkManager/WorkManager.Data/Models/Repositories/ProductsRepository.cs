using WorkManager.Data.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TNT.Core.Helpers.Data;

namespace WorkManager.Data.Models.Repositories
{
    public partial interface IProductsRepository
    {
        #region CREATE
        Products Convert(CreateProductViewModel model);
        Products PrepareCreate(Products model);
        Products Create(CreateProductViewModel model);
        #endregion

        #region READ
        IQueryable<Products> Filter(IQueryable<Products> from, ProductFilter filter);
        IQueryable<Products> QueryFields(IQueryable<Products> from, string[] generalFields);
        object SelectFields(IQueryable<Products> from, string[] generalFields, int? count);
        //-field: desc by field, +field: asc by field
        IQueryable<Products> Sort(IQueryable<Products> from, string[] sortings);
        IQueryable<Products> SelectPage(IQueryable<Products> model, int page, int limit);
        object GetData(ProductFilter filter,
           string[] sorts,
           string[] fields,
           int page,
           int limit, bool countTotal);
        #endregion

        #region UPDATE
        Products Edit(Products entity, EditProductViewModel editModel);
        #endregion

        #region DELETE
        #endregion
    }

    public partial class ProductsRepository
    {

        #region CREATE
        public Products Convert(CreateProductViewModel model)
        {
            return model.ToEntity();
        }
        public Products PrepareCreate(Products model)
        {
            return model;
        }
        public Products Create(CreateProductViewModel model)
        {
            var entity = Convert(model);
            entity = PrepareCreate(entity);
            entity = Create(entity).Entity;
            return entity;
        }
        #endregion

        #region READ
        public IQueryable<Products> Filter(IQueryable<Products> from, ProductFilter filter)
        {
            if (filter.ids != null)
                from = from.Where(p => filter.ids.Contains(p.Id));
            if (filter.name_contains != null)
                from = from.Where(p => filter.name_contains.Any(s => p.Name.Contains(s, StringComparison.OrdinalIgnoreCase)));
            return from;
        }

        public IQueryable<Products> QueryFields(IQueryable<Products> from, string[] generalFields)
        {
            var finalFields = new List<string>();
            foreach (var f in generalFields)
            {
                if (ProductGeneralFields.Mapping.ContainsKey(f))
                    finalFields.AddRange(ProductGeneralFields.Mapping[f]);
            }
            var fieldsArr = finalFields.ToArray();
            from = from.SelectOnly(SelectOption.ByPropertyName, fieldsArr);
            return from;
        }

        public object SelectFields(IQueryable<Products> from, string[] generalFields, int? count)
        {
            var list = new List<IDictionary<string, object>>();
            var model = from.ToList();
            foreach (var p in model)
            {
                var obj = new Dictionary<string, object>();
                foreach (var f in generalFields)
                {
                    switch (f)
                    {
                        case ProductGeneralFields.INFO:
                            obj["id"] = p.Id;
                            obj["name"] = p.Name;
                            break;
                    }
                }
                list.Add(obj);
            }

            var resp = new Dictionary<string, object>();
            resp["results"] = list;
            if (count != null)
                resp["total_count"] = count;
            return resp;
        }
        //-field: desc by field, +field: asc by field
        public IQueryable<Products> Sort(IQueryable<Products> from, string[] sortings)
        {
            foreach (var s in sortings)
            {
                var asc = s[0] == 'a';
                var fieldName = s.Remove(0, 1);
                switch (fieldName)
                {
                    case ProductSortFields.Name:
                        if (asc)
                            from = from.OrderBy(p => p.Name);
                        else from = from.OrderByDescending(p => p.Name);
                        break;
                }
            }
            return from;
        }

        public IQueryable<Products> SelectPage(IQueryable<Products> model, int page, int limit)
        {
            return model.Skip(page * limit).Take(limit);
        }

        public object GetData(ProductFilter filter,
           string[] sorts,
           string[] fields,
           int page,
           int limit, bool countTotal)
        {
            var models = Get().AsQueryable();
            models = Filter(models, filter);
            models = QueryFields(models, fields);
            models = Sort(models, sorts);
            int? count = null;
            if (countTotal)
                count = models.Count();
            models = SelectPage(models, page, limit);
            var result = SelectFields(models, fields, count);
            return result;
        }
        #endregion

        #region UPDATE
        public Products Edit(Products entity, EditProductViewModel editModel)
        {
            entity.Name = editModel.Name;
            return entity;
        }
        #endregion

        #region DELETE
        #endregion
    }
}