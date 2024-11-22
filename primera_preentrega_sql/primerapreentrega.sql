-- Crear la base de datos
CREATE DATABASE ConsultorioKinesiologia;
USE ConsultorioKinesiologia;

-- Tabla: Pacientes
CREATE TABLE Pacientes (
    idPaciente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fechaNacimiento DATE NOT NULL,
    telefono VARCHAR(15),
    email VARCHAR(100),
    direccion VARCHAR(150)
);

-- Tabla: Profesionales
CREATE TABLE Profesionales (
    idProfesional INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100),
    matricula VARCHAR(50) UNIQUE NOT NULL
);

-- Tabla: Turnos
CREATE TABLE Turnos (
    idTurno INT AUTO_INCREMENT PRIMARY KEY,
    idPaciente INT NOT NULL,
    idProfesional INT NOT NULL,
    fechaHora DATETIME NOT NULL,
    motivo VARCHAR(200),
    estado ENUM('Pendiente', 'Realizado', 'Cancelado') DEFAULT 'Pendiente',
    FOREIGN KEY (idPaciente) REFERENCES Pacientes(idPaciente),
    FOREIGN KEY (idProfesional) REFERENCES Profesionales(idProfesional)
);

-- Tabla: Tratamientos
CREATE TABLE Tratamientos (
    idTratamiento INT AUTO_INCREMENT PRIMARY KEY,
    nombreTratamiento VARCHAR(100) NOT NULL,
    descripcion TEXT,
    duracionEstimada INT COMMENT 'Duración en minutos'
);

-- Tabla: Sesiones
CREATE TABLE Sesiones (
    idSesion INT AUTO_INCREMENT PRIMARY KEY,
    idTurno INT NOT NULL,
    idTratamiento INT NOT NULL,
    fechaHora DATETIME NOT NULL,
    notas TEXT,
    FOREIGN KEY (idTurno) REFERENCES Turnos(idTurno),
    FOREIGN KEY (idTratamiento) REFERENCES Tratamientos(idTratamiento)
);

-- Tabla: Diagnosticos
CREATE TABLE Diagnosticos (
    idDiagnostico INT AUTO_INCREMENT PRIMARY KEY,
    idPaciente INT NOT NULL,
    descripcion TEXT NOT NULL,
    fechaDiagnostico DATE NOT NULL,
    FOREIGN KEY (idPaciente) REFERENCES Pacientes(idPaciente)
);

-- Tabla: Facturas
CREATE TABLE Facturas (
    idFactura INT AUTO_INCREMENT PRIMARY KEY,
    idPaciente INT NOT NULL,
    fechaEmision DATE NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (idPaciente) REFERENCES Pacientes(idPaciente)
);

-- Tabla: DetalleFactura
CREATE TABLE DetalleFactura (
    idDetalle INT AUTO_INCREMENT PRIMARY KEY,
    idFactura INT NOT NULL,
    idTratamiento INT NOT NULL,
    cantidad INT NOT NULL,
    precioUnitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (idFactura) REFERENCES Facturas(idFactura),
    FOREIGN KEY (idTratamiento) REFERENCES Tratamientos(idTratamiento)
);

-- Tabla: Usuarios (Sistema)
CREATE TABLE Usuarios (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nombreUsuario VARCHAR(50) NOT NULL UNIQUE,
    passwordHash VARCHAR(255) NOT NULL,
    rol ENUM('Admin', 'Recepcionista', 'Kinesiólogo') NOT NULL
);

-- Tabla: HistorialClinico
CREATE TABLE HistorialClinico (
    idHistorial INT AUTO_INCREMENT PRIMARY KEY,
    idPaciente INT NOT NULL,
    descripcion TEXT NOT NULL,
    fechaRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idPaciente) REFERENCES Pacientes(idPaciente)
);