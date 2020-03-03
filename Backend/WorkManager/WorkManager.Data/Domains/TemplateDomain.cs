using WorkManager.Data.Models;
using WorkManager.Data.Models.Repositories;
using WorkManager.Data.ViewModels;
using System;
using System.Collections.Generic;
using System.Text;
using TNT.Core.Helpers.DI;

namespace WorkManager.Data.Domains
{
    public class TemplateDomain : BaseDomain
    {
        public TemplateDomain(ServiceInjection inj) : base(inj)
        {
        }

        public Products CreateProduct(CreateProductViewModel model)
        {
            var repo = _uow.GetService<IProductsRepository>();
            return repo.Create(model);
        }

        public Products GetProductById(int id)
        {
            var repo = _uow.GetService<IProductsRepository>();
            return repo.FindById(id);
        }

        public object GetProductsData(ProductFilter filter,
            string[] sorts,
            string[] fields,
            int page,
            int limit, bool countTotal)
        {
            var repo = _uow.GetService<IProductsRepository>();
            return repo.GetData(filter, sorts, fields, page, limit, countTotal);
        }

        public Products EditProduct(Products entity, EditProductViewModel model)
        {
            var repo = _uow.GetService<IProductsRepository>();
            repo.Edit(entity, model);
            return entity;
        }

        public Products Delete(Products entity)
        {
            var repo = _uow.GetService<IProductsRepository>();
            return repo.Remove(entity).Entity;
        }

    }
}