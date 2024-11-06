var express = require('express');
const multer = require('multer');
const path = require('path');
const uuid = require('uuid');
var router = express.Router();
const { body, validationResult } = require('express-validator');
let jwt = require('jsonwebtoken');
const RutinaController = require('../controls/RutinaController');
var rutinaController = new RutinaController();
const GrupoMuscularController = require('../controls/GrupoMuscularController');
var grupoMuscularController = new GrupoMuscularController();
const EjercicioController = require('../controls/EjercicioController');
var ejercicioController = new EjercicioController();
/*const storage_archivo = (dir) => multer.diskStorage({
  destination: path.join(__dirname,'../public/archivos'+dir),
  filename: (req, file, cb) => {
    const partes = file.originalname.split('.');
    const extension = partes[partes.length - 1];
    cb(null, uuid.v4()+"."+extension);
  }
 
});*/

/*const extensiones_aceptadas_archivo = (req, file, cb) => {
  const allowedExtensions = ['.pdf','.docx', '.xlsx'];
  const ext = path.extname(file.originalname);
  if (allowedExtensions.includes(ext)) {
    cb(null, true);
  } else {
    cb(new Error('Solo se permiten archivos PDF, DOCX y XLSX.'));
  }
};*/

/*const upload_archivo_practica = multer({ storage: storage_archivo('/practicas'), limits: {
  fileSize: 2 * 1024 * 1024 // 2 MB en bytes
},fileFilter: extensiones_aceptadas_archivo});*/

var auth = function middleware(req, res, next) {
  const token = req.headers['x-api-token'];
  //console.log(req.headers);
  if (token) {
    require('dotenv').config();
    const llave = process.env.KEY;
    jwt.verify(token, llave, async (err, decoded) => {
      if (err) {
        console.log('aqui', err);
        res.status(401);
        res.json({ msg: "Token no valido!", code: 401 });
      } else {
        var models = require('../models');
        var cuenta = models.cuenta;
        req.decoded = decoded;
        console.log("Aca\n\n");
        console.log(decoded);
        let aux = await cuenta.findOne({ where: { external_id: req.decoded.external } });
        if (aux) {
          next();
        } else {
          res.status(401);
          res.json({ msg: "Token no valido!", code: 401 });
        }
      }

    });
  } else {
    res.status(401);
    res.json({ msg: "No existe token!", code: 401 });
  }
}

//Usar este para modulos de admin
var authAdmin = function middleware(req, res, next) {
  const token = req.headers['x-api-token'];
  console.log(token);
  
  if (token) {
    
    require('dotenv').config();
    const llave = process.env.KEY;
    jwt.verify(token, llave, async (err, decoded) => {
      if (err) {
        console.log('aqui', err);
        res.status(401);
        res.json({ msg: "Token no validoo!", code: 401 });
      } else {
        var models = require('../models');
        var cuenta = models.cuenta;
        req.decoded = decoded;
        console.log("Aca\n\n");
        console.log(decoded);
        if (decoded.rol_nombre == "admin") {
          let aux = await cuenta.findOne({ where: { external_id: req.decoded.external } });
          if (aux) {
            next();
          } else {
            res.status(401);
            res.json({ msg: "Token no valido!", code: 401 });
          }
        } else {
          
          res.status(401);
            res.json({ msg: "Token no valido!", code: 401 });
        }
      }

    });
  } else {
    
    res.status(401);
    res.json({ msg: "No existe token!", code: 401 });
  }
}

/* GET users listing. */
router.get('/', function (req, res, next) {
  res.json({ "version": "1.0", "name": "pis-grupo-c-backend" });
});


router.post('/rutinas', rutinaController.guardar);
router.get('/rutinas/:id', rutinaController.getRutinas);
router.post('/rutinas/addEjercicio', rutinaController.agregarEjercicio);


router.get('/gruposmusculares', grupoMuscularController.getGruposMusculares);

router.get('/ejercicios/:id_grupo_muscular', ejercicioController.getEjercicioPGM);

module.exports = router;
