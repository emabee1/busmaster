package POJOs;



import javax.persistence.*;

@Entity
@Table(name = "category_starttimes")
public class CategoryStarttimesModel {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "category_starttimes_id")
    private Long _categoryStarttimesId;

    @Column(name = "category")
    private CategoryModel _categoryModel;

    public Long getCategoryStarttimesId() {
        return _categoryStarttimesId;
    }

    public void setCategoryStarttimesId(Long categoryStarttimesId) {
        _categoryStarttimesId = categoryStarttimesId;
    }

    public CategoryModel getCategoryModel() {
        return _categoryModel;
    }

    public void setCategoryModel(CategoryModel categoryModel) {
        _categoryModel = categoryModel;
    }
}
