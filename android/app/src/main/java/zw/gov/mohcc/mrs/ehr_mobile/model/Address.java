package zw.gov.mohcc.mrs.ehr_mobile.model;


public class Address {
    public Address(String street, String city, String town) {
        this.street = street;
        this.city = city;
        this.town = town;
    }

    private String street;
    private String suburbVillage;

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getTown() {
        return town;
    }

    public void setTown(String town) {
        this.town = town;
    }

    private String city;
    private String town;

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getSuburbVillage() {
        return suburbVillage;
    }

    public void setSuburbVillage(String suburbVillage) {
        this.suburbVillage = suburbVillage;
    }
}
