package POJOs;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "timetable")
public class TimetableModel {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "timetable_id")
    private Long _timetableId;

    @Column(name = "valid_from")
    private LocalDate _validFrom;

    @Column(name = "valid_to")
    private LocalDate _validTo;

    public Long getTimetableId() {
        return _timetableId;
    }

    public void setTimetableId(Long timetableId) {
        _timetableId = timetableId;
    }

    public LocalDate getValidFrom() {
        return _validFrom;
    }

    public void setValidFrom(LocalDate validFrom) {
        _validFrom = validFrom;
    }

    public LocalDate getValidTo() {
        return _validTo;
    }

    public void setValidTo(LocalDate validTo) {
        _validTo = validTo;
    }
}
