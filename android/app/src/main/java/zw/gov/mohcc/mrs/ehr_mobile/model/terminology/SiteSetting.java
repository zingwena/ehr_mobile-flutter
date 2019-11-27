package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;

@Entity
public class SiteSetting extends BaseEntity {

    @NonNull
    private String name;
    private String userName;
    private String password;
    private String ipAddress;
    @TypeConverters(DateConverter.class)
    private Date lastEhrPull;
    @TypeConverters(DateConverter.class)
    private Date lastEhrPush;

    public SiteSetting() {
    }

    @Ignore
    public SiteSetting(@NonNull String id, @NonNull String name) {
        super(id);
        this.name = name;
    }

    @NonNull
    public String getName() {
        return name;
    }

    public void setName(@NonNull String name) {
        this.name = name;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public Date getLastEhrPull() {
        return lastEhrPull;
    }

    public void setLastEhrPull(Date lastEhrPull) {
        this.lastEhrPull = lastEhrPull;
    }

    public Date getLastEhrPush() {
        return lastEhrPush;
    }

    public void setLastEhrPush(Date lastEhrPush) {
        this.lastEhrPush = lastEhrPush;
    }

    @Override
    public String toString() {
        return super.toString().concat("SiteSetting{" +
                "name='" + name + '\'' +
                ", userName='" + userName + '\'' +
                ", password='" + password + '\'' +
                ", ipAddress='" + ipAddress + '\'' +
                ", lastEhrPull=" + lastEhrPull +
                ", lastEhrPush=" + lastEhrPush +
                '}');
    }
}
