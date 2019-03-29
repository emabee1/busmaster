package at.fhv.tf.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @author Lukas Bals
 */
@Entity
@Table(name = "category")
public class CategoryModel {
    @Id
    @Column(name = "category")
    private String _category;

    @Column(name = "description")
    private String _description;

    public String getCategory() {
        return _category;
    }

    public void setCategory(String category) {
        this._category = category;
    }

    public String getDescription() {
        return _description;
    }

    public void setDescription(String description) {
        this._description = description;
    }

    @Override
    public String toString() {
        return getCategory();
    }
}

