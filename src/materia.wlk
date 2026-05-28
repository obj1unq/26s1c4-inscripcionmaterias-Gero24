class Materia {
  const carrera
  const requisito = sinRequisito
  const inscriptos = []
  const listaDeEspera = []
  var cupo = null
  
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
