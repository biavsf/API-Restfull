package com.example.condservice.repository

import com.example.condservice.entity.usuario
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface UsuarioRepository: JpaRepository<usuario, Long> {


}