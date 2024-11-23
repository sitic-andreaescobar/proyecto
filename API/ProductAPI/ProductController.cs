using DAO;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VO;
using BLL;

namespace Services
{
    [Route("Product/[action]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        #region Variables & properties
        private readonly DAOClass _dao;
        private readonly ILogger<ProductController> _logger;

        private DAOClass Dao { get { return _dao;  } }
        #endregion

        #region Construct
        public ProductController(ILogger<ProductController> logger)
        {
            _dao = new();
            _logger = logger;
        }
        #endregion

        #region Endpoints
        [HttpGet]
        public ActionResult<ProductResponse> GetById(int id)
        {
            ProductResponse response = new();

            try
            {
                response.Product = new BLL.ProductBLL(Dao).GetById(id);
            }
            catch(Exception ex)
            {
                response.Error = Utilities.ErrorHandler.Handler(ex);
                _logger.LogError($"Error en ProductController {nameof(GetById)}: ${ex.Message}");
            }

            return response;
        }

        [HttpGet]
        public ActionResult<ProductResponse> GetAll()
        {
            ProductResponse response = new();

            try
            {
                response.Products = new BLL.ProductBLL(Dao).GetAll();
            }
            catch (Exception ex)
            {
                response.Error = Utilities.ErrorHandler.Handler(ex);
                _logger.LogError($"Error en ProductController {nameof(GetAll)}: ${ex.Message}");
            }

            return response;
        }

        #region DML (Insert, Update, Delete)
        [HttpPost]
        public ActionResult<ProductResponse> Insert(ProductRequest request)
        {
            ProductResponse response = new();

            try
            {
                response.IsSucess = new BLL.ProductBLL(Dao).ExecuteDBAction(eDbAction.Insert, request.Product);
            }
            catch (Exception ex)
            {
                response.Error = Utilities.ErrorHandler.Handler(ex);
                _logger.LogError($"Error en ProductController {nameof(Insert)}: ${ex.Message}");
            }

            return response;
        }

        [HttpPut]
        public ActionResult<ProductResponse> Update(ProductRequest request)
        {
            ProductResponse response = new();

            try
            {
                response.IsSucess = new BLL.ProductBLL(Dao).ExecuteDBAction(eDbAction.Update, request.Product);
            }
            catch (Exception ex)
            {
                response.Error = Utilities.ErrorHandler.Handler(ex);
                _logger.LogError($"Error en ProductController {nameof(Update)}: ${ex.Message}");
            }

            return response;
        }

        [HttpDelete]
        public ActionResult<ProductResponse> Delete(int id)
        {
            ProductResponse response = new();

            try
            {
                response.IsSucess = new BLL.ProductBLL(Dao).ExecuteDBAction(eDbAction.Delete, new() { Id = id });
            }
            catch (Exception ex)
            {
                response.Error = Utilities.ErrorHandler.Handler(ex);
                _logger.LogError($"Error en ProductController {nameof(Delete)}: ${ex.Message}");
            }

            return response;
        }
        #endregion

        #endregion
    }
}
