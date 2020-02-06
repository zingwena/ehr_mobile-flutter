package zw.gov.mohcc.mrs.ehr_mobile.model.person;


import androidx.annotation.NonNull;

public class Address {
    @NonNull
    private String street;
    @NonNull
    private String suburbVillage;
    @NonNull
    private String city;
    @NonNull
    private String town;

    public Address(String street, String city, String town) {
        this.street = street;
        this.city = city;
        this.town = town;
    }

    @NonNull
    public String getStreet() {
        return street;
    }

    public void setStreet(@NonNull String street) {
        this.street = street;
    }

    @NonNull
    public String getSuburbVillage() {
        return suburbVillage;
    }

    public void setSuburbVillage(@NonNull String suburbVillage) {
        this.suburbVillage = suburbVillage;
    }

    @NonNull
    public String getCity() {
        return city;
    }

    public void setCity(@NonNull String city) {
        this.city = city;
    }

    @NonNull
    public String getTown() {
        return town;
    }

    public void setTown(@NonNull String town) {
        this.town = town;
    }

    @Override
    public String toString() {
        return "Address{" +
                "street='" + street + '\'' +
                ", suburbVillage='" + suburbVillage + '\'' +
                ", city='" + city + '\'' +
                ", town='" + town + '\'' +
                '}';
    }
}
