using Microsoft.AspNetCore.Mvc;
using QRCoder;

namespace QRCodeGen.Controllers
{
    [Route("/api/[controller]")]
    public class QrController : Controller
    {
        [HttpGet]
        public IActionResult Get([FromQuery] string url)
        {
            using var qrGenerator = new QRCodeGenerator();
            var qrCodeData = qrGenerator.CreateQrCode(url, QRCodeGenerator.ECCLevel.Q);
            var qrCode = new PngByteQRCode(qrCodeData);
            var qrCodeBytes = qrCode.GetGraphic(20);

            return File(qrCodeBytes, "image/png");
        }
    }
}
