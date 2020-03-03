using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WorkManager.Data;
using WorkManager.Data.Models;
using WorkManager.Data.Domains;
using WorkManager.Data.ViewModels;
using TNT.Core.Http.DI;

namespace WorkManager.WebApi.Controllers
{
    [Route("api/products")]
    [ApiController]
    [InjectionFilter]
    public class ProductsController : BaseController
    {
        private static NLog.Logger _logger = NLog.LogManager.GetCurrentClassLogger();

        [HttpGet("")]
        public IActionResult Get([FromQuery]ProductFilter filter,
            [FromQuery]string[] sorts,
            [FromQuery]string[] fields,
            [FromQuery]int page = 0,
            [FromQuery]int limit = 50,
            [FromQuery]bool count_total = false)
        {
            try
            {
                var domain = Service<TemplateDomain>();

                if (fields.Length == 0)
                    fields = new string[] { ProductGeneralFields.INFO };
                else
                {
                    var maps = ProductGeneralFields.Mapping;
                    if (fields.Any(f => f == null || !maps.ContainsKey(f)))
                        return BadRequest(new ApiResult()
                        {
                            Code = ResultCode.Unsupported,
                            Data = null,
                            Message = ResultCode.Unsupported.DisplayName() + ": fields"
                        });
                }

                var result = domain.GetProductsData(filter,
                    sorts,
                    fields, page, limit, count_total);
                return Ok(result);
            }
            catch (Exception e)
            {
                _logger.Error(e);
                return Error(new ApiResult()
                {
                    Code = ResultCode.UnknownError,
                    Message = ResultCode.UnknownError.DisplayName() + ": " + e.Message
                });
            }
        }

        [HttpPatch("{id}")]
        public IActionResult Edit(int id,
            EditProductViewModel model)
        {
            try
            {

                var domain = Service<TemplateDomain>();
                var product = domain.GetProductById(id);
                if (product == null)
                    return NotFound(new ApiResult()
                    {
                        Code = ResultCode.NotFound,
                        Message = ResultCode.NotFound.DisplayName()
                    });

                domain.EditProduct(product, model);
                _uow.SaveChanges();
                _logger.CustomProperties(new { id, model }).Info("Edit product");

                return NoContent();
            }
            catch (Exception e)
            {
                _logger.Error(e);
                return Error(new ApiResult()
                {
                    Code = ResultCode.UnknownError,
                    Message = ResultCode.UnknownError.DisplayName() + ": " + e.Message
                });
            }
        }

        [HttpPost("")]
        public IActionResult Create(CreateProductViewModel model)
        {
            try
            {

                var domain = Service<TemplateDomain>();
                var entity = domain.CreateProduct(model);
                _uow.SaveChanges();
                _logger.CustomProperties(new { model }).Info("Create product");

                return Ok(entity.Id);
            }
            catch (Exception e)
            {
                _logger.Error(e);
                return Error(new ApiResult()
                {
                    Code = ResultCode.UnknownError,
                    Message = ResultCode.UnknownError.DisplayName() + ": " + e.Message
                });
            }
        }

        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            try
            {
                var domain = Service<TemplateDomain>();
                var product = domain.GetProductById(id);
                if (product == null)
                    return NotFound(new ApiResult()
                    {
                        Code = ResultCode.NotFound,
                        Message = ResultCode.NotFound.DisplayName()
                    });

                domain.Delete(product);
                _uow.SaveChanges();
                _logger.CustomProperties(new { id }).Info("Delete product");

                return NoContent();
            }
            catch (Exception e)
            {
                _logger.Error(e);
                return Error(new ApiResult()
                {
                    Code = ResultCode.UnknownError,
                    Message = ResultCode.UnknownError.DisplayName() + ": " + e.Message
                });
            }
        }

    }
}