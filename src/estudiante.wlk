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
  
  method materiasDeLasCarrerasQueCursa() = carreras.map(
    { carrera => carrera.materiasDeLaCarrera() }
  ).flatten()
  
  method puedeInscribirseA(materia) = ((self.cursaLaCarreraDe(
    materia
  ) && self.noAprobo(materia)) && self.noEstaInscriptoEn(
    materia
  )) && materia.cumpleRequisitosPara(self)
  
  method cursaLaCarreraDe(materia) = self.carrerasQueEstaInscripto().contains(
    materia.carreraALaQuePertenece()
  )
  
  method noAprobo(materia) = !self.aproboMateria(materia)
  
  method noEstaInscriptoEn(materia) = !self.estaInscriptoEn(materia)
  
  method estaInscriptoEn(materia) = materia.tieneInscriptoAl(self)

  method materiasQueEstaCursando() = self.materiasDeLasCarrerasQueCursa().filter({materia => materia.tieneInscriptoAl(self)})
  
  method materiasEnListaDeEspera() = self.materiasDeLasCarrerasQueCursa().filter({materia => materia.estudiantesEnListaDeEspera(self)})

  method materiasQueMePuedoInscribir(carrera) {

    if(!self.carrerasQueEstaInscripto().contains(carrera)) {
      throw new Exception(message = "No esta inscripto en la carrera") 
  } else {
      return carrera.materiasDeLaCarrera().filter({materia => self.puedeInscribirseA(materia)})
  }
    }
    
}