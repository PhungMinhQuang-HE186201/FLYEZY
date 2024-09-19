/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author PMQUANG
 */
public class Airline {
    private int id;
    private String name;
    private String image;

    public Airline(int id) {
        this.id = id;
    }

    public Airline(String name, String image) {
        this.name = name;
        this.image = image;
    }


    public Airline(int id, String name, String image) {
        this.id = id;
        this.name = name;
        this.image = image;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }


    @Override
    public String toString() {
        return "Airline{" + "id=" + id + ", name=" + name + ", image=" + image + '}';
    }



   
    

    
}
