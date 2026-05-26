class Estudiante {
  const carreras = []
  const materiasAprobadas = []
  
  method carrerasQueEstaInscripto() = carreras
  
  method agregarMateriaAprobada(materiaAprobada) {
    if (self.aproboMateria(materiaAprobada.materia())) {
      throw new Exception(message = "La materia ya fue aprobada")
    }
    materiasAprobadas.add(materiaAprobada)
  }
  
  method inscribirCarrera(carrera) {
    carreras.add(carrera)
  }
  
  method aproboMateria(materia) = self.materiasQueYaAprobo().contains(materia)
  
  method cantidadDeMateriasAprobadas() = materiasAprobadas.size()
  
  method materiasQueYaAprobo() = materiasAprobadas.map({aprobada => aprobada.materia()})
  
  method promedio() {
    if (self.cantidadDeMateriasAprobadas() == 0) {
      return 0
    }
    const notas = materiasAprobadas.map({ aprobada => aprobada.nota() })
    return notas.sum() / self.cantidadDeMateriasAprobadas()
  }
  
  method materiasDeCarrerasInscriptas() = carreras.map(
    { carrera => carrera.materiasDeLaCarrera() }
  ).flatten()

  method puedeInscribirseA(materia) = self.cursaLaCarreraDe(materia) &&
    self.noAprobo(materia) &&
    materia.cumpleRequisitosPara(self)

  method cursaLaCarreraDe(materia) = self.carrerasQueEstaInscripto().contains(materia.carreraALaQuePertenece())

  method noAprobo(materia) = !self.aproboMateria(materia)
}



class Carrera {
  const materias = []
  
  method materiasDeLaCarrera() = materias
  
  method agregarMateria(materia) {
    materias.add(materia)
  }
}

class Materia {
  const carrera
  const requisito = sinRequisito
  
  method carreraALaQuePertenece() = carrera

  method cumpleRequisitosPara(estudiante) {
    requisito.cumplePara(estudiante)
  }
}

class MateriaAprobada {
  const materia
  const nota
  
  method materia() = materia
  
  method nota() = nota
}

object sinRequisito {
  method cumplePara(estudiante) = true
}

class RequisitoPorCorrelativas {
  const correlativas = []

  method cumplePara(estudiante) =
    correlativas.all({ materia => estudiante.aproboMateria(materia) })
}


