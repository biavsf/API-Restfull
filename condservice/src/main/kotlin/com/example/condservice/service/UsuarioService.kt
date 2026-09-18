package com.example.condservice.service

import com.example.condservice.entity.usuario
import com.example.condservice.repository.UsuarioRepository
import org.springframework.stereotype.Service



@Service
class UsuarioService (val repository: UsuarioRepository) {

    fun cadastrar(usuario: usuario): usuario{
        return repository.save(usuario)
    }
    fun listar(): List<usuario>{
       return repository.findAll()
    }

    fun buscar(id: Long): usuario?{
        return repository.findById(id).orElse(null)
        }

    fun excluir(id: Long): Boolean {
        if (!repository.existsById(id)){
            return false
        }
        repository.deleteById(id)
        return true
    }

    fun atualizar(id: Long, usuario: usuario): usuario?{
        var usuarioexiste = repository.findById(id).orElse(null) ?: return null
        usuarioexiste.email = usuario.email
        usuarioexiste.senha = usuario.senha
        return repository.save(usuarioexiste)

    }
}