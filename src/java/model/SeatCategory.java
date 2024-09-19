/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class SeatCategory {
    private int id;
    private String name;
    private int numberOfSeat;
    private String image;
    private int Plane_Categoryid;

    public SeatCategory() {
    }
    
    public SeatCategory(String name, int numberOfSeat, String image, int Plane_Categoryid) {
        this.name = name;
        this.numberOfSeat = numberOfSeat;
        this.image = image;
        this.Plane_Categoryid = Plane_Categoryid;
    }

    public SeatCategory(int id, String name, int numberOfSeat, String image, int Plane_Categoryid) {
        this.id = id;
        this.name = name;
        this.numberOfSeat = numberOfSeat;
        this.image = image;
        this.Plane_Categoryid = Plane_Categoryid;
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

    public int getNumberOfSeat() {
        return numberOfSeat;
    }

    public void setNumberOfSeat(int numberOfSeat) {
        this.numberOfSeat = numberOfSeat;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getPlane_Categoryid() {
        return Plane_Categoryid;
    }

    public void setPlane_Categoryid(int Plane_Categoryid) {
        this.Plane_Categoryid = Plane_Categoryid;
    }
    
    
}
