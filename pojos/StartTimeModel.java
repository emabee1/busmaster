package POJOs;

import javax.persistence.*;
import java.time.LocalTime;

@Entity
@Table(name = "starttime")
public class StartTimeModel {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "starttime_id")
    private Long _startTimeId;

    @ManyToOne
    @Column(name = "category_starttimes_id")
    private CategoryStarttimesModel _categoryStarttimesModel;

    @Column(name = "time")
    private LocalTime _localTime;

    @Column(name = "required_capacity")
    private int requiredCapacity;

    public Long getStartTimeId() {
        return _startTimeId;
    }

    public void setStartTimeId(Long startTimeId) {
        _startTimeId = startTimeId;
    }

    public CategoryStarttimesModel getCategoryStarttimesModel() {
        return _categoryStarttimesModel;
    }

    public void setCategoryStarttimesModel(CategoryStarttimesModel categoryStarttimesModel) {
        _categoryStarttimesModel = categoryStarttimesModel;
    }

    public LocalTime getLocalTime() {
        return _localTime;
    }

    public void setLocalTime(LocalTime localTime) {
        _localTime = localTime;
    }

    public int getRequiredCapacity() {
        return requiredCapacity;
    }

    public void setRequiredCapacity(int requiredCapacity) {
        requiredCapacity = requiredCapacity;
    }
}
