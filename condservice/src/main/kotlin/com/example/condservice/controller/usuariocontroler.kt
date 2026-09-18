package com.example.condservice.controller

import com.example.condservice.entity.usuario
import com.example.condservice.service.UsuarioService
import org.apache.catalina.connector.Response
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController


@RequestMapping("/usuario")
@RestController
class usuariocontroler ( val service: UsuarioService) {

    @PostMapping
            fun cadastrar(@RequestBody usuario: usuario): ResponseEntity<usuario> {
            return ResponseEntity.ok(service.cadastrar(usuario))
           }
    @GetMapping
            fun listar(): ResponseEntity<List<usuario>> {
            return ResponseEntity.ok(service.listar())
      }

    @PutMapping("/{id}")
            fun atualizar(@PathVariable("id") id : Long,
             @RequestBody usuario: usuario): ResponseEntity<usuario> {
    val atualizado=service.atualizar(id,usuario) ?:return ResponseEntity.notFound().build()
    return ResponseEntity.ok(atualizado)
        }

    @DeleteMapping("/{id}")
            fun excluir(@PathVariable("id") id : Long,
            @RequestBody usuario: usuario): ResponseEntity<Void> {
    val excluir = service.excluir(id) ?:return ResponseEntity.notFound().build()
    if(!excluir){
           return ResponseEntity.notFound().build()
    }
        return ResponseEntity.noContent().build()
    }
}

