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
    @NonNull
    private String userName;
    @NonNull
    private String password;
    @NonNull
    private String ipAddress;
    @NonNull
    @TypeConverters(DateConverter.class)
    private Date lastEhrPull;
    @NonNull
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

    @NonNull
    public String getUserName() {
        return userName;
    }

    public void setUserName(@NonNull String userName) {
        this.userName = userName;
    }

    @NonNull
    public String getPassword() {
        return password;
    }

    public void setPassword(@NonNull String password) {
        this.password = password;
    }

    @NonNull
    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(@NonNull String ipAddress) {
        this.ipAddress = ipAddress;
    }

    @NonNull
    public Date getLastEhrPull() {
        return lastEhrPull;
    }

    public void setLastEhrPull(@NonNull Date lastEhrPull) {
        this.lastEhrPull = lastEhrPull;
    }

    @NonNull
    public Date getLastEhrPush() {
        return lastEhrPush;
    }

    public void setLastEhrPush(@NonNull Date lastEhrPush) {
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
