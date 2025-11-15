-- Crear base de datos
CREATE DATABASE chest_xray_pneumonia;

-- Conectar a la base de datos
\c chest_xray_pneumonia;

-- Crear tabla `patients`
CREATE TABLE patients (
    patient_id VARCHAR(255) PRIMARY KEY,  -- Identificador único del paciente
    age INT,  -- Edad del paciente
    gender CHAR(1)  -- Género del paciente (M/F)
);

-- Crear tabla `images`
CREATE TABLE images (
    image_id VARCHAR(255) PRIMARY KEY,  -- Identificador único de la imagen
    patient_id VARCHAR(255),  -- Relación con la tabla de pacientes
    image_path TEXT,  -- Ruta del archivo de la imagen
    label VARCHAR(50),  -- Etiqueta (Normal/Pneumonia)
    date DATE,  -- Fecha de la radiografía
    image_resolution VARCHAR(50),  -- Resolución de la imagen (e.g. 224x224)
    file_size INT,  -- Tamaño del archivo en bytes
    image_format VARCHAR(10),  -- Formato de la imagen (e.g. JPEG)
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)  -- Relación con `patients`
);

-- Crear tabla `model_predictions`
CREATE TABLE model_predictions (
    prediction_id SERIAL PRIMARY KEY,  -- Identificador único de la predicción
    image_id VARCHAR(255),  -- Relación con la tabla `images`
    classification VARCHAR(50),  -- Clasificación (Normal/Pneumonia)
    confidence_score FLOAT,  -- Puntaje de confianza del modelo
    model_used VARCHAR(100),  -- Nombre del modelo usado
    FOREIGN KEY (image_id) REFERENCES images(image_id)  -- Relación con `images`
);

-- Agregar índices para mejorar el rendimiento de las consultas
CREATE INDEX idx_patient_id ON images(patient_id);
CREATE INDEX idx_image_id ON model_predictions(image_id);