package POJOs;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "shift_day")
public class ShiftDayModel {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "shift_day_id")
    private Long _shiftdayId;

    @ManyToOne
    @Column(name = "bus_id")
    private BusModel _busModel;

    @Column(name = "date")
    private LocalDate _date;

    @Column(name="category")
    private CategoryModel _category;

    public Long getShiftdayId() {
        return _shiftdayId;
    }

    public void setShiftdayId(Long shiftdayId) {
        _shiftdayId = shiftdayId;
    }

    public BusModel getBusModel() {
        return _busModel;
    }

    public void setBusModel(BusModel busModel) {
        _busModel = busModel;
    }

    public LocalDate getDate() {
        return _date;
    }

    public void setDate(LocalDate date) {
        _date = date;
    }

    public CategoryModel getCategory() {
        return _category;
    }

    public void setCategory(CategoryModel category) {
        _category = category;
    }
}
