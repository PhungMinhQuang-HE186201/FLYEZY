/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import java.sql.Time;

/**
 *
 * @author PMQUANG
 */
public class FlightDetails {
    private int id;
    private Date date;
    private Time time;
    private int price;
    private int flightId;
    private int planeCategoryId;
    private int statusId;

    public FlightDetails() {
    }

    public FlightDetails(int id, Date date, Time time, int price, int flightId, int planeCategoryId, int statusId) {
        this.id = id;
        this.date = date;
        this.time = time;
        this.price = price;
        this.flightId = flightId;
        this.planeCategoryId = planeCategoryId;
        this.statusId = statusId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Time getTime() {
        return time;
    }

    public void setTime(Time time) {
        this.time = time;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getFlightId() {
        return flightId;
    }

    public void setFlightId(int flightId) {
        this.flightId = flightId;
    }

    public int getPlaneCategoryId() {
        return planeCategoryId;
    }

    public void setPlaneCategoryId(int planeCategoryId) {
        this.planeCategoryId = planeCategoryId;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    @Override
    public String toString() {
        return "FlightDetails{" + "id=" + id + ", date=" + date + ", time=" + time + ", price=" + price + ", flightId=" + flightId + ", planeCategoryId=" + planeCategoryId + ", statusId=" + statusId + '}';
    }
    
}
