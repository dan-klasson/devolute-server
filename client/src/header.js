import React from 'react'
import Nav from 'react-bootstrap/Nav'
import Navbar from 'react-bootstrap/Navbar'

export default function Header() {
  return (
    <Navbar bg="light" expand="lg">
      <Navbar.Brand href="#home">Devolute Image Upload Test</Navbar.Brand>
      <Navbar.Toggle aria-controls="basic-navbar-nav" />
      <Navbar.Collapse id="basic-navbar-nav">
        <Nav className="ml-auto" pullRight>
          <Nav.Link href="#login">Login</Nav.Link>
          <Nav.Link href="#signup">Register</Nav.Link>
        </Nav>
      </Navbar.Collapse>
    </Navbar>
  )
}