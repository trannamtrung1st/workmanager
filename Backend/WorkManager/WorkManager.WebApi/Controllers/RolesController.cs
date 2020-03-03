using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WorkManager.Data;
using WorkManager.Data.Models;
using WorkManager.Data.Domains;
using WorkManager.Data.ViewModels;
using TNT.Core.Helpers.DI;
using TNT.Core.Http.DI;

namespace WorkManager.WebApi.Controllers
{
    [Route("api/roles")]
    [ApiController]
    [InjectionFilter]
    public class RolesController : BaseController
    {
        [Inject]
        private readonly IdentityDomain _iDomain;

        [HttpGet("")]
        public IActionResult GetRoles()
        {

            try
            {
                var roles = _iDomain.GetRoles().ToList();
                return Ok(roles);
            }
            catch (Exception e)
            {
                return Error(new ApiResult()
                {
                    Code = ResultCode.UnknownError,
                    Message = ResultCode.UnknownError.DisplayName() + ": " + e.Message
                });
            }
        }

        [HttpPost("")]
        public async Task<IActionResult> CreateRole(CreateRoleViewModel model)
        {

            try
            {
                var role = new AppRoles
                {
                    Name = model.Name,
                };
                var result = await _iDomain.CreateRoleAsync(role);
                if (result.Succeeded)
                    return Ok(result);
                foreach (var err in result.Errors)
                    ModelState.AddModelError(err.Code, err.Description);

                return BadRequest(new ApiResult()
                {
                    Code = ResultCode.FailValidation,
                    Data = ModelState,
                    Message = ResultCode.FailValidation.DisplayName()
                });
            }
            catch (Exception e)
            {
                return Error(new ApiResult()
                {
                    Code = ResultCode.UnknownError,
                    Message = ResultCode.UnknownError.DisplayName() + ": " + e.Message
                });
            }
        }

        [HttpPatch("{name}")]
        public async Task<IActionResult> EditRole(string name, EditRoleViewModel model)
        {

            try
            {
                var role = _iDomain.GetRoleByName(name);
                var result = await _iDomain.EditRoleAsync(role, model);
                if (result.Succeeded)
                    return Ok(role);
                foreach (var err in result.Errors)
                    ModelState.AddModelError(err.Code, err.Description);

                return BadRequest(new ApiResult()
                {
                    Code = ResultCode.FailValidation,
                    Data = ModelState,
                    Message = ResultCode.FailValidation.DisplayName()
                });
            }
            catch (Exception e)
            {
                return Error(new ApiResult()
                {
                    Code = ResultCode.UnknownError,
                    Message = ResultCode.UnknownError.DisplayName() + ": " + e.Message
                });
            }
        }

        [HttpDelete("{name}")]
        public async Task<IActionResult> RemoveRole(string name)
        {
            try
            {
                var role = _iDomain.GetRoleByName(name);
                var result = await _iDomain.RemoveRoleAsync(role);
                if (result.Succeeded)
                    return Ok(role);
                foreach (var err in result.Errors)
                    ModelState.AddModelError(err.Code, err.Description);

                return BadRequest(new ApiResult()
                {
                    Code = ResultCode.FailValidation,
                    Data = ModelState,
                    Message = ResultCode.FailValidation.DisplayName()
                });
            }
            catch (Exception e)
            {
                return Error(new ApiResult()
                {
                    Code = ResultCode.UnknownError,
                    Message = ResultCode.UnknownError.DisplayName() + ": " + e.Message
                });
            }
        }
    }
}