// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CulturaMarruecos
 * @dev Registro de la termodinamica del Tagine y balances aromaticos.
 * Serie: Sabores de Africa (4/54)
 */
contract CulturaMarruecos {

    struct Plato {
        string nombre;
        string ingredientes;
        string preparacion;
        bool usaTagine;           // Sistema de condensacion termica
        bool balanceDulceSalado;  // Uso de frutos secos (ciruelas, albaricoques)
        string especiaBase;       // Ras el Hanout, Comino, Azafran
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public registroCulinario;
    uint256 public totalRegistros;
    address public owner;

    constructor() {
        owner = msg.sender;
        // Inauguramos con el Cordero con Ciruelas
        registrarPlato(
            "Tagine de Cordero y Ciruelas", 
            "Cordero, ciruelas pasas, almendras tostadas, canela, azafran.",
            "Cocer en tagine de barro a fuego lento, permitiendo la condensacion constante del vapor.",
            true, 
            true, 
            "Ras el Hanout"
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _ingredientes,
        string memory _preparacion,
        bool _tagine, 
        bool _dulceSalado,
        string memory _especia
    ) public {
        require(bytes(_nombre).length > 0, "Nombre requerido");

        totalRegistros++;
        registroCulinario[totalRegistros] = Plato({
            nombre: _nombre,
            ingredientes: _ingredientes,
            preparacion: _preparacion,
            usaTagine: _tagine,
            balanceDulceSalado: _dulceSalado,
            especiaBase: _especia,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre,
        string memory ingredientes,
        bool tagine,
        bool dulceSalado,
        uint256 likes
    ) {
        require(_id > 0 && _id <= totalRegistros, "ID inexistente");
        Plato storage p = registroCulinario[_id];
        return (p.nombre, p.ingredientes, p.usaTagine, p.balanceDulceSalado, p.likes);
    }
}
