/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

public class Order {

    private int id;
    private int flightDetailId;
    private String code;
    private String contactName;
    private String contactPhone;
    private String contactEmail;
    private int totalPrice;
    private Integer accountsId; // Nullable field
    private int paymentTypesId;
    private Timestamp paymentTime; // Nullable field
    private int flightTypeId;
    private Integer discountId; // Nullable field
    private int Status_id;

    // Default constructor
    public Order() {
    }

    public Order(int id, int flightDetailId, String code, String contactName, String contactPhone, String contactEmail, int totalPrice, Integer accountsId, int paymentTypesId, Timestamp paymentTime, int flightTypeId, Integer discountId, int Status_id) {
        this.id = id;
        this.flightDetailId = flightDetailId;
        this.code = code;
        this.contactName = contactName;
        this.contactPhone = contactPhone;
        this.contactEmail = contactEmail;
        this.totalPrice = totalPrice;
        this.accountsId = accountsId;
        this.paymentTypesId = paymentTypesId;
        this.paymentTime = paymentTime;
        this.flightTypeId = flightTypeId;
        this.discountId = discountId;
        this.Status_id = Status_id;
    }



    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getFlightDetailId() {
        return flightDetailId;
    }

    public void setFlightDetailId(int flightDetailId) {
        this.flightDetailId = flightDetailId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public String getContactEmail() {
        return contactEmail;
    }

    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Integer getAccountsId() {
        return accountsId;
    }

    public void setAccountsId(Integer accountsId) {
        this.accountsId = accountsId;
    }

    public int getPaymentTypesId() {
        return paymentTypesId;
    }

    public void setPaymentTypesId(int paymentTypesId) {
        this.paymentTypesId = paymentTypesId;
    }

    public Timestamp getPaymentTime() {
        return paymentTime;
    }

    public void setPaymentTime(Timestamp paymentTime) {
        this.paymentTime = paymentTime;
    }

    public int getFlightTypeId() {
        return flightTypeId;
    }

    public void setFlightTypeId(int flightTypeId) {
        this.flightTypeId = flightTypeId;
    }

    public Integer getDiscountId() {
        return discountId;
    }

    public void setDiscountId(Integer discountId) {
        this.discountId = discountId;
    }

    public int getStatus_id() {
        return Status_id;
    }

    public void setStatus_id(int Status_id) {
        this.Status_id = Status_id;
    }

    @Override
    public String toString() {
        return "Order{" + "id=" + id + ", flightDetailId=" + flightDetailId + ", code=" + code + ", contactName=" + contactName + ", contactPhone=" + contactPhone + ", contactEmail=" + contactEmail + ", totalPrice=" + totalPrice + ", accountsId=" + accountsId + ", paymentTypesId=" + paymentTypesId + ", paymentTime=" + paymentTime + ", flightTypeId=" + flightTypeId + ", discountId=" + discountId + ", Status_id=" + Status_id + '}';
    }

    
}

