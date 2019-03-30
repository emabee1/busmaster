package POJOs;

import javax.persistence.*;

@Entity
@Table(name = "path")
public class PathModel {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "path_id")
    private Long _pathId;

    @Column(name = "category_starttimes_id")
    @ManyToOne
    private CategoryStarttimesModel _categoryStarttimesModel;

    @Column(name = "route_id")
    @ManyToOne
    private RouteModel _routeModel;

    @Column(name = "description")
    private String _description;

    public Long getPathId() {
        return _pathId;
    }

    public void setPathId(Long pathId) {
        _pathId = pathId;
    }

    public CategoryStarttimesModel getCategoryStarttimesModel() {
        return _categoryStarttimesModel;
    }

    public void setCategoryStarttimesModel(CategoryStarttimesModel categoryStarttimesModel) {
        _categoryStarttimesModel = categoryStarttimesModel;
    }

    public RouteModel getRouteModel() {
        return _routeModel;
    }

    public void setRouteModel(RouteModel routeModel) {
        _routeModel = routeModel;
    }

    public String getDescription() {
        return _description;
    }

    public void setDescription(String description) {
        _description = description;
    }
}
