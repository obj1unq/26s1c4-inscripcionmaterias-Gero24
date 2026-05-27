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
  
  method materiasQueYaAprobo() = materiasAprobadas.map(
    { aprobada => aprobada.materia() }
  )
  
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
  
  method puedeInscribirseA(materia) = self.cursaLaCarreraDe(materia) && self.noAprobo(materia) && self.noEstaInscriptoEn(materia) && materia.cumpleRequisitosPara(self)
  
  
  method cursaLaCarreraDe(materia) = self.carrerasQueEstaInscripto().contains(
    materia.carreraALaQuePertenece()
  )
  
  method noAprobo(materia) = !self.aproboMateria(materia)

  method noEstaInscriptoEn(materia) = !self.estaInscriptoEn(materia)

  method estaInscriptoEn(materia) = materia.tieneInscriptoAl(self)


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
  const inscriptos = []
  const listaDeEspera = []
  var cupo
  
  method carreraALaQuePertenece() = carrera
  
  method cumpleRequisitosPara(estudiante) = requisito.cumplePara(estudiante)
  
  method estudiantesInscriptos() = inscriptos

  method estudiantesEnListaDeEspera() = listaDeEspera

  method tieneInscriptoAl(estudiante) = inscriptos.contains(estudiante)

  method inscribirEstudiante(estudiante) {
  if (!estudiante.puedeInscribirseA(self)) {
    throw new Exception(message = "No cumple con los requisitos de la materia")
  }

  if (self.hayCupo()) {
    inscriptos.add(estudiante)
  } else {
    listaDeEspera.add(estudiante)
  }
}

  method cupos() = cupo

  method cupos(cantidad) {
    cupo = cantidad
  }

  method hayCupo() = cupo > inscriptos.size()  

  method darDeBajaInscripto(estudiante) {
  if (self.tieneInscriptoAl(estudiante)) {
    inscriptos.remove(estudiante)
    self.ocuparCupoConPrimeroEnEspera()
  }
}
  
  method ocuparCupoConPrimeroEnEspera() {
  if (!listaDeEspera.isEmpty()) {
    const primerEstudiante = listaDeEspera.first()
    listaDeEspera.remove(primerEstudiante)
    inscriptos.add(primerEstudiante)
  }
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
  
  method cumplePara(estudiante) = correlativas.all(
    { materia => estudiante.aproboMateria(materia) }
  )
}
