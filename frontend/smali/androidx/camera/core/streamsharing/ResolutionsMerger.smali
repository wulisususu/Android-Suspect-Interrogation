.class public Landroidx/camera/core/streamsharing/ResolutionsMerger;
.super Ljava/lang/Object;
.source "ResolutionsMerger.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/camera/core/streamsharing/ResolutionsMerger$CompareAspectRatioByOverlappingAreaToReference;
    }
.end annotation


# static fields
.field private static final SAME_AREA_WIDTH_HEIGHT_RATIO:D

.field private static final TAG:Ljava/lang/String; = "ResolutionsMerger"


# instance fields
.field private final mCameraInfo:Landroidx/camera/core/impl/CameraInfoInternal;

.field private final mChildSizesCache:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Landroidx/camera/core/impl/UseCaseConfig<",
            "*>;",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;>;"
        }
    .end annotation
.end field

.field private final mChildrenConfigs:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Landroidx/camera/core/impl/UseCaseConfig<",
            "*>;>;"
        }
    .end annotation
.end field

.field private final mFallbackAspectRatio:Landroid/util/Rational;

.field private final mSensorAspectRatio:Landroid/util/Rational;

.field private final mSensorSize:Landroid/util/Size;

.field private final mSizeSorter:Landroidx/camera/core/internal/SupportedOutputSizesSorter;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const-wide v0, 0x4002f684bda12f68L    # 2.3703703703703702

    .line 71
    invoke-static {v0, v1}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v0

    sput-wide v0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->SAME_AREA_WIDTH_HEIGHT_RATIO:D

    return-void
.end method

.method private constructor <init>(Landroid/util/Size;Landroidx/camera/core/impl/CameraInfoInternal;Ljava/util/Set;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/util/Size;",
            "Landroidx/camera/core/impl/CameraInfoInternal;",
            "Ljava/util/Set<",
            "Landroidx/camera/core/impl/UseCaseConfig<",
            "*>;>;)V"
        }
    .end annotation

    .line 96
    new-instance v0, Landroidx/camera/core/internal/SupportedOutputSizesSorter;

    invoke-direct {v0, p2, p1}, Landroidx/camera/core/internal/SupportedOutputSizesSorter;-><init>(Landroidx/camera/core/impl/CameraInfoInternal;Landroid/util/Size;)V

    invoke-direct {p0, p1, p2, p3, v0}, Landroidx/camera/core/streamsharing/ResolutionsMerger;-><init>(Landroid/util/Size;Landroidx/camera/core/impl/CameraInfoInternal;Ljava/util/Set;Landroidx/camera/core/internal/SupportedOutputSizesSorter;)V

    return-void
.end method

.method constructor <init>(Landroid/util/Size;Landroidx/camera/core/impl/CameraInfoInternal;Ljava/util/Set;Landroidx/camera/core/internal/SupportedOutputSizesSorter;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/util/Size;",
            "Landroidx/camera/core/impl/CameraInfoInternal;",
            "Ljava/util/Set<",
            "Landroidx/camera/core/impl/UseCaseConfig<",
            "*>;>;",
            "Landroidx/camera/core/internal/SupportedOutputSizesSorter;",
            ")V"
        }
    .end annotation

    .line 103
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 85
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mChildSizesCache:Ljava/util/Map;

    iput-object p1, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mSensorSize:Landroid/util/Size;

    .line 105
    invoke-static {p1}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->getSensorAspectRatio(Landroid/util/Size;)Landroid/util/Rational;

    move-result-object p1

    iput-object p1, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mSensorAspectRatio:Landroid/util/Rational;

    .line 106
    invoke-static {p1}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->getFallbackAspectRatio(Landroid/util/Rational;)Landroid/util/Rational;

    move-result-object p1

    iput-object p1, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mFallbackAspectRatio:Landroid/util/Rational;

    iput-object p2, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mCameraInfo:Landroidx/camera/core/impl/CameraInfoInternal;

    iput-object p3, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mChildrenConfigs:Ljava/util/Set;

    iput-object p4, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mSizeSorter:Landroidx/camera/core/internal/SupportedOutputSizesSorter;

    return-void
.end method

.method constructor <init>(Landroidx/camera/core/impl/CameraInternal;Ljava/util/Set;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/camera/core/impl/CameraInternal;",
            "Ljava/util/Set<",
            "Landroidx/camera/core/impl/UseCaseConfig<",
            "*>;>;)V"
        }
    .end annotation

    .line 90
    invoke-interface {p1}, Landroidx/camera/core/impl/CameraInternal;->getCameraControlInternal()Landroidx/camera/core/impl/CameraControlInternal;

    move-result-object v0

    invoke-interface {v0}, Landroidx/camera/core/impl/CameraControlInternal;->getSensorRect()Landroid/graphics/Rect;

    move-result-object v0

    invoke-static {v0}, Landroidx/camera/core/impl/utils/TransformUtils;->rectToSize(Landroid/graphics/Rect;)Landroid/util/Size;

    move-result-object v0

    .line 91
    invoke-interface {p1}, Landroidx/camera/core/impl/CameraInternal;->getCameraInfoInternal()Landroidx/camera/core/impl/CameraInfoInternal;

    move-result-object p1

    .line 90
    invoke-direct {p0, v0, p1, p2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;-><init>(Landroid/util/Size;Landroidx/camera/core/impl/CameraInfoInternal;Ljava/util/Set;)V

    return-void
.end method

.method static synthetic access$000(Landroid/util/Rational;Landroid/util/Rational;)F
    .locals 0

    .line 67
    invoke-static {p0, p1}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->computeAreaOverlapping(Landroid/util/Rational;Landroid/util/Rational;)F

    move-result p0

    return p0
.end method

.method private areCroppingInDifferentDirection(FFF)Z
    .locals 3

    cmpl-float p1, p1, p2

    const/4 v0, 0x0

    if-eqz p1, :cond_3

    cmpl-float v1, p2, p3

    if-nez v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v2, 0x1

    if-lez p1, :cond_2

    cmpg-float p1, p2, p3

    if-gez p1, :cond_1

    move v0, v2

    :cond_1
    return v0

    :cond_2
    if-lez v1, :cond_3

    move v0, v2

    :cond_3
    :goto_0
    return v0
.end method

.method private static computeAreaOverlapping(Landroid/util/Rational;Landroid/util/Rational;)F
    .locals 1

    .line 849
    invoke-virtual {p0}, Landroid/util/Rational;->floatValue()F

    move-result p0

    .line 850
    invoke-virtual {p1}, Landroid/util/Rational;->floatValue()F

    move-result p1

    cmpl-float v0, p0, p1

    if-lez v0, :cond_0

    div-float/2addr p1, p0

    goto :goto_0

    :cond_0
    div-float p1, p0, p1

    :goto_0
    return p1
.end method

.method private filterOutChildSizesCausingDoubleCropping(Landroid/util/Rational;Ljava/util/List;)Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/util/Rational;",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;)",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;"
        }
    .end annotation

    .line 499
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 500
    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :cond_0
    :goto_0
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/util/Size;

    .line 501
    invoke-direct {p0, p1, v1}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->isDoubleCropping(Landroid/util/Rational;Landroid/util/Size;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 502
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    return-object v0
.end method

.method private static filterOutChildSizesThatWillNeverBeSelected(Ljava/util/List;)Ljava/util/List;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;)",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;"
        }
    .end annotation

    .line 728
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 729
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 730
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :cond_0
    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_5

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/util/Size;

    .line 733
    invoke-interface {v0}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/util/Rational;

    .line 734
    invoke-static {v2, v4}, Landroidx/camera/core/impl/utils/AspectRatioUtil;->hasMatchingAspectRatio(Landroid/util/Size;Landroid/util/Rational;)Z

    move-result v5

    if-eqz v5, :cond_1

    goto :goto_1

    :cond_2
    const/4 v4, 0x0

    :goto_1
    if-eqz v4, :cond_3

    .line 742
    invoke-interface {v0, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/util/Size;

    invoke-static {v3}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/util/Size;

    .line 743
    invoke-virtual {v2}, Landroid/util/Size;->getHeight()I

    move-result v5

    invoke-virtual {v3}, Landroid/util/Size;->getHeight()I

    move-result v6

    if-gt v5, v6, :cond_0

    .line 744
    invoke-virtual {v2}, Landroid/util/Size;->getWidth()I

    move-result v5

    invoke-virtual {v3}, Landroid/util/Size;->getWidth()I

    move-result v6

    if-gt v5, v6, :cond_0

    .line 745
    invoke-virtual {v2}, Landroid/util/Size;->getWidth()I

    move-result v5

    invoke-virtual {v3}, Landroid/util/Size;->getWidth()I

    move-result v6

    if-ne v5, v6, :cond_4

    .line 746
    invoke-virtual {v2}, Landroid/util/Size;->getHeight()I

    move-result v5

    invoke-virtual {v3}, Landroid/util/Size;->getHeight()I

    move-result v3

    if-ne v5, v3, :cond_4

    goto :goto_0

    .line 750
    :cond_3
    invoke-static {v2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->toRational(Landroid/util/Size;)Landroid/util/Rational;

    move-result-object v4

    .line 753
    :cond_4
    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 754
    invoke-interface {v0, v4, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_5
    return-object v1
.end method

.method static filterOutParentSizeThatIsTooSmall(Ljava/util/Collection;Ljava/util/List;)Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Landroid/util/Size;",
            ">;",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;)",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;"
        }
    .end annotation

    .line 706
    invoke-interface {p0}, Ljava/util/Collection;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_3

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_1

    .line 710
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 711
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_1
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/util/Size;

    .line 712
    invoke-static {p0, v1}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->isAnyChildSizeCanBeCroppedOutWithoutUpscalingParent(Ljava/util/Collection;Landroid/util/Size;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 713
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_2
    return-object v0

    .line 707
    :cond_3
    :goto_1
    new-instance p0, Ljava/util/ArrayList;

    invoke-direct {p0}, Ljava/util/ArrayList;-><init>()V

    return-object p0
.end method

.method static filterResolutionsByAspectRatio(Landroid/util/Rational;Ljava/util/List;)Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/util/Rational;",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;)",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;"
        }
    .end annotation

    .line 684
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 685
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_0
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/util/Size;

    .line 686
    invoke-static {v1, p0}, Landroidx/camera/core/impl/utils/AspectRatioUtil;->hasMatchingAspectRatio(Landroid/util/Size;Landroid/util/Rational;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 687
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    return-object v0
.end method

.method private static findCloserAspectRatio(Landroid/util/Size;)Landroid/util/Rational;
    .locals 4

    .line 598
    invoke-virtual {p0}, Landroid/util/Size;->getWidth()I

    move-result v0

    int-to-double v0, v0

    invoke-virtual {p0}, Landroid/util/Size;->getHeight()I

    move-result p0

    int-to-double v2, p0

    div-double/2addr v0, v2

    sget-wide v2, Landroidx/camera/core/streamsharing/ResolutionsMerger;->SAME_AREA_WIDTH_HEIGHT_RATIO:D

    cmpl-double p0, v0, v2

    if-lez p0, :cond_0

    .line 601
    sget-object p0, Landroidx/camera/core/impl/utils/AspectRatioUtil;->ASPECT_RATIO_16_9:Landroid/util/Rational;

    return-object p0

    .line 603
    :cond_0
    sget-object p0, Landroidx/camera/core/impl/utils/AspectRatioUtil;->ASPECT_RATIO_4_3:Landroid/util/Rational;

    return-object p0
.end method

.method private getCameraSupportedHighResolutions()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mCameraInfo:Landroidx/camera/core/impl/CameraInfoInternal;

    const/16 v1, 0x22

    .line 277
    invoke-interface {v0, v1}, Landroidx/camera/core/impl/CameraInfoInternal;->getSupportedHighResolutions(I)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method private getCameraSupportedResolutions()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mCameraInfo:Landroidx/camera/core/impl/CameraInfoInternal;

    const/16 v1, 0x22

    .line 272
    invoke-interface {v0, v1}, Landroidx/camera/core/impl/CameraInfoInternal;->getSupportedResolutions(I)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method private static getCenterCroppedRectangle(Landroid/util/Rational;Landroid/util/Size;)Landroid/graphics/Rect;
    .locals 4

    .line 617
    invoke-virtual {p1}, Landroid/util/Size;->getWidth()I

    move-result v0

    .line 618
    invoke-virtual {p1}, Landroid/util/Size;->getHeight()I

    move-result v1

    .line 619
    invoke-static {p1}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->toRational(Landroid/util/Size;)Landroid/util/Rational;

    move-result-object p1

    .line 622
    invoke-virtual {p0}, Landroid/util/Rational;->floatValue()F

    move-result v2

    invoke-virtual {p1}, Landroid/util/Rational;->floatValue()F

    move-result v3

    cmpl-float v2, v2, v3

    const/4 v3, 0x0

    if-nez v2, :cond_0

    .line 623
    new-instance p0, Landroid/graphics/RectF;

    int-to-float p1, v0

    int-to-float v0, v1

    invoke-direct {p0, v3, v3, p1, v0}, Landroid/graphics/RectF;-><init>(FFFF)V

    goto :goto_1

    .line 624
    :cond_0
    invoke-virtual {p0}, Landroid/util/Rational;->floatValue()F

    move-result v2

    invoke-virtual {p1}, Landroid/util/Rational;->floatValue()F

    move-result p1

    cmpl-float p1, v2, p1

    const/high16 v2, 0x40000000    # 2.0f

    if-lez p1, :cond_1

    int-to-float p1, v0

    .line 625
    invoke-virtual {p0}, Landroid/util/Rational;->floatValue()F

    move-result p0

    div-float p0, p1, p0

    int-to-float v0, v1

    sub-float/2addr v0, p0

    div-float/2addr v0, v2

    .line 627
    new-instance v1, Landroid/graphics/RectF;

    add-float/2addr p0, v0

    invoke-direct {v1, v3, v0, p1, p0}, Landroid/graphics/RectF;-><init>(FFFF)V

    goto :goto_0

    :cond_1
    int-to-float p1, v1

    .line 629
    invoke-virtual {p0}, Landroid/util/Rational;->floatValue()F

    move-result p0

    mul-float/2addr p0, p1

    int-to-float v0, v0

    sub-float/2addr v0, p0

    div-float/2addr v0, v2

    .line 631
    new-instance v1, Landroid/graphics/RectF;

    add-float/2addr p0, v0

    invoke-direct {v1, v0, v3, p0, p1}, Landroid/graphics/RectF;-><init>(FFFF)V

    :goto_0
    move-object p0, v1

    .line 635
    :goto_1
    new-instance p1, Landroid/graphics/Rect;

    invoke-direct {p1}, Landroid/graphics/Rect;-><init>()V

    .line 636
    invoke-virtual {p0, p1}, Landroid/graphics/RectF;->round(Landroid/graphics/Rect;)V

    return-object p1
.end method

.method private getChildrenRequiredResolutions()Ljava/util/Set;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Set<",
            "Landroid/util/Size;",
            ">;"
        }
    .end annotation

    .line 487
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iget-object v1, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mChildrenConfigs:Ljava/util/Set;

    .line 488
    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroidx/camera/core/impl/UseCaseConfig;

    .line 489
    invoke-direct {p0, v2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->getSortedChildSizes(Landroidx/camera/core/impl/UseCaseConfig;)Ljava/util/List;

    move-result-object v2

    .line 490
    invoke-interface {v0, v2}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z

    goto :goto_0

    :cond_0
    return-object v0
.end method

.method static getCropRectOfReferenceAspectRatio(Landroid/util/Size;Landroid/util/Size;)Landroid/graphics/Rect;
    .locals 0

    .line 564
    invoke-static {p1}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->toRational(Landroid/util/Size;)Landroid/util/Rational;

    move-result-object p1

    .line 565
    invoke-static {p1, p0}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->getCenterCroppedRectangle(Landroid/util/Rational;Landroid/util/Size;)Landroid/graphics/Rect;

    move-result-object p0

    return-object p0
.end method

.method private static getFallbackAspectRatio(Landroid/util/Rational;)Landroid/util/Rational;
    .locals 3

    .line 649
    sget-object v0, Landroidx/camera/core/impl/utils/AspectRatioUtil;->ASPECT_RATIO_4_3:Landroid/util/Rational;

    invoke-virtual {p0, v0}, Landroid/util/Rational;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 650
    sget-object p0, Landroidx/camera/core/impl/utils/AspectRatioUtil;->ASPECT_RATIO_16_9:Landroid/util/Rational;

    return-object p0

    .line 651
    :cond_0
    sget-object v0, Landroidx/camera/core/impl/utils/AspectRatioUtil;->ASPECT_RATIO_16_9:Landroid/util/Rational;

    invoke-virtual {p0, v0}, Landroid/util/Rational;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 652
    sget-object p0, Landroidx/camera/core/impl/utils/AspectRatioUtil;->ASPECT_RATIO_4_3:Landroid/util/Rational;

    return-object p0

    .line 654
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Invalid sensor aspect-ratio: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method static getParentSizesThatAreTooLarge(Ljava/util/Collection;Ljava/util/List;)Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Landroid/util/Size;",
            ">;",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;)",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;"
        }
    .end annotation

    .line 783
    invoke-interface {p0}, Ljava/util/Collection;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_4

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_1

    .line 789
    :cond_0
    invoke-static {p1}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->removeDuplicates(Ljava/util/List;)Ljava/util/List;

    move-result-object p1

    .line 791
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 792
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_1
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/util/Size;

    .line 793
    invoke-static {p0, v1}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->isAllChildSizesCanBeCroppedOutWithoutUpscalingParent(Ljava/util/Collection;Landroid/util/Size;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 794
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 800
    :cond_2
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result p0

    if-nez p0, :cond_3

    .line 801
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result p0

    add-int/lit8 p0, p0, -0x1

    invoke-interface {v0, p0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    :cond_3
    return-object v0

    .line 784
    :cond_4
    :goto_1
    new-instance p0, Ljava/util/ArrayList;

    invoke-direct {p0}, Ljava/util/ArrayList;-><init>()V

    return-object p0
.end method

.method private getPreferredChildSizePairInternal(Landroid/graphics/Rect;Landroidx/camera/core/impl/UseCaseConfig;Z)Landroid/util/Pair;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/graphics/Rect;",
            "Landroidx/camera/core/impl/UseCaseConfig<",
            "*>;Z)",
            "Landroid/util/Pair<",
            "Landroid/graphics/Rect;",
            "Landroid/util/Size;",
            ">;"
        }
    .end annotation

    if-eqz p3, :cond_0

    .line 192
    invoke-static {p1}, Landroidx/camera/core/impl/utils/TransformUtils;->rectToSize(Landroid/graphics/Rect;)Landroid/util/Size;

    move-result-object p3

    .line 193
    invoke-virtual {p0, p3, p2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->getPreferredChildSizeForViewport(Landroid/util/Size;Landroidx/camera/core/impl/UseCaseConfig;)Landroid/util/Size;

    move-result-object p2

    goto :goto_0

    .line 195
    :cond_0
    invoke-static {p1}, Landroidx/camera/core/impl/utils/TransformUtils;->rectToSize(Landroid/graphics/Rect;)Landroid/util/Size;

    move-result-object p1

    .line 196
    invoke-virtual {p0, p1, p2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->getPreferredChildSize(Landroid/util/Size;Landroidx/camera/core/impl/UseCaseConfig;)Landroid/util/Size;

    move-result-object p2

    .line 197
    invoke-static {p1, p2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->getCropRectOfReferenceAspectRatio(Landroid/util/Size;Landroid/util/Size;)Landroid/graphics/Rect;

    move-result-object p1

    .line 200
    :goto_0
    new-instance p3, Landroid/util/Pair;

    invoke-direct {p3, p1, p2}, Landroid/util/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    return-object p3
.end method

.method private static getSensorAspectRatio(Landroid/util/Size;)Landroid/util/Rational;
    .locals 3

    .line 589
    invoke-static {p0}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->findCloserAspectRatio(Landroid/util/Size;)Landroid/util/Rational;

    move-result-object v0

    .line 590
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "The closer aspect ratio to the sensor size ("

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v1, ") is "

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v1, "."

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    const-string v1, "ResolutionsMerger"

    invoke-static {v1, p0}, Landroidx/camera/core/Logger;->d(Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method

.method private getSortedChildSizes(Landroidx/camera/core/impl/UseCaseConfig;)Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/camera/core/impl/UseCaseConfig<",
            "*>;)",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mChildrenConfigs:Ljava/util/Set;

    .line 458
    invoke-interface {v0, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mChildSizesCache:Ljava/util/Map;

    .line 464
    invoke-interface {v0, p1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mChildSizesCache:Ljava/util/Map;

    .line 465
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/List;

    invoke-static {p1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/List;

    return-object p1

    :cond_0
    iget-object v0, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mSizeSorter:Landroidx/camera/core/internal/SupportedOutputSizesSorter;

    .line 468
    invoke-virtual {v0, p1}, Landroidx/camera/core/internal/SupportedOutputSizesSorter;->getSortedSupportedOutputSizes(Landroidx/camera/core/impl/UseCaseConfig;)Ljava/util/List;

    move-result-object v0

    .line 469
    invoke-static {v0}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->filterOutChildSizesThatWillNeverBeSelected(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iget-object v1, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mChildSizesCache:Ljava/util/Map;

    .line 470
    invoke-interface {v1, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object v0

    .line 459
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Invalid child config: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static getSupportedPrivResolutions(Ljava/util/List;)Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Landroid/util/Pair<",
            "Ljava/lang/Integer;",
            "[",
            "Landroid/util/Size;",
            ">;>;)",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;"
        }
    .end annotation

    .line 571
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :cond_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/util/Pair;

    .line 572
    iget-object v1, v0, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v1, Ljava/lang/Integer;

    const/16 v2, 0x22

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/Integer;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 573
    iget-object p0, v0, Landroid/util/Pair;->second:Ljava/lang/Object;

    check-cast p0, [Landroid/util/Size;

    invoke-static {p0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object p0

    return-object p0

    .line 577
    :cond_1
    new-instance p0, Ljava/util/ArrayList;

    invoke-direct {p0}, Ljava/util/ArrayList;-><init>()V

    return-object p0
.end method

.method private groupSizesByAspectRatio(Ljava/util/List;)Ljava/util/Map;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;)",
            "Ljava/util/Map<",
            "Landroid/util/Rational;",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;>;"
        }
    .end annotation

    .line 410
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 413
    sget-object v1, Landroidx/camera/core/impl/utils/AspectRatioUtil;->ASPECT_RATIO_4_3:Landroid/util/Rational;

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 414
    sget-object v1, Landroidx/camera/core/impl/utils/AspectRatioUtil;->ASPECT_RATIO_16_9:Landroid/util/Rational;

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 417
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 418
    sget-object v2, Landroidx/camera/core/impl/utils/AspectRatioUtil;->ASPECT_RATIO_4_3:Landroid/util/Rational;

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 419
    sget-object v2, Landroidx/camera/core/impl/utils/AspectRatioUtil;->ASPECT_RATIO_16_9:Landroid/util/Rational;

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 422
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_4

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/util/Size;

    .line 423
    invoke-virtual {v2}, Landroid/util/Size;->getHeight()I

    move-result v3

    if-gtz v3, :cond_0

    goto :goto_0

    .line 429
    :cond_0
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/util/Rational;

    .line 430
    invoke-static {v2, v4}, Landroidx/camera/core/impl/utils/AspectRatioUtil;->hasMatchingAspectRatio(Landroid/util/Size;Landroid/util/Rational;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 431
    invoke-interface {v0, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/List;

    goto :goto_1

    :cond_2
    const/4 v3, 0x0

    :goto_1
    if-nez v3, :cond_3

    .line 438
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 439
    invoke-static {v2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->toRational(Landroid/util/Size;)Landroid/util/Rational;

    move-result-object v4

    .line 440
    invoke-interface {v1, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 441
    invoke-interface {v0, v4, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 444
    :cond_3
    invoke-static {v3}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_4
    return-object v0
.end method

.method static hasUpscaling(Landroid/util/Size;Landroid/util/Size;)Z
    .locals 2

    .line 824
    invoke-virtual {p0}, Landroid/util/Size;->getHeight()I

    move-result v0

    invoke-virtual {p1}, Landroid/util/Size;->getHeight()I

    move-result v1

    if-gt v0, v1, :cond_1

    .line 825
    invoke-virtual {p0}, Landroid/util/Size;->getWidth()I

    move-result p0

    invoke-virtual {p1}, Landroid/util/Size;->getWidth()I

    move-result p1

    if-le p0, p1, :cond_0

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 p0, 0x1

    :goto_1
    return p0
.end method

.method private static isAllChildSizesCanBeCroppedOutWithoutUpscalingParent(Ljava/util/Collection;Landroid/util/Size;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Landroid/util/Size;",
            ">;",
            "Landroid/util/Size;",
            ")Z"
        }
    .end annotation

    .line 809
    invoke-interface {p0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :cond_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/util/Size;

    .line 810
    invoke-static {v0, p1}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->hasUpscaling(Landroid/util/Size;Landroid/util/Size;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 p0, 0x0

    return p0

    :cond_1
    const/4 p0, 0x1

    return p0
.end method

.method private static isAnyChildSizeCanBeCroppedOutWithoutUpscalingParent(Ljava/util/Collection;Landroid/util/Size;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Landroid/util/Size;",
            ">;",
            "Landroid/util/Size;",
            ")Z"
        }
    .end annotation

    .line 762
    invoke-interface {p0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :cond_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/util/Size;

    .line 763
    invoke-static {v0, p1}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->hasUpscaling(Landroid/util/Size;Landroid/util/Size;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_1
    const/4 p0, 0x0

    return p0
.end method

.method private isDoubleCropping(Landroid/util/Rational;Landroid/util/Size;)Z
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mSensorAspectRatio:Landroid/util/Rational;

    .line 512
    invoke-virtual {v0, p1}, Landroid/util/Rational;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p2, p1}, Landroidx/camera/core/impl/utils/AspectRatioUtil;->hasMatchingAspectRatio(Landroid/util/Size;Landroid/util/Rational;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mSensorAspectRatio:Landroid/util/Rational;

    .line 520
    invoke-virtual {v0}, Landroid/util/Rational;->floatValue()F

    move-result v0

    .line 521
    invoke-virtual {p1}, Landroid/util/Rational;->floatValue()F

    move-result p1

    .line 522
    invoke-static {p2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->toRationalWithMod16Considered(Landroid/util/Size;)Landroid/util/Rational;

    move-result-object p2

    invoke-virtual {p2}, Landroid/util/Rational;->floatValue()F

    move-result p2

    .line 519
    invoke-direct {p0, v0, p1, p2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->areCroppingInDifferentDirection(FFF)Z

    move-result p1

    return p1

    :cond_1
    :goto_0
    const/4 p1, 0x0

    return p1
.end method

.method private isDoubleCropping(Landroid/util/Size;Landroid/util/Size;)Z
    .locals 0

    .line 527
    invoke-static {p1}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->toRationalWithMod16Considered(Landroid/util/Size;)Landroid/util/Rational;

    move-result-object p1

    .line 528
    invoke-direct {p0, p1, p2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->isDoubleCropping(Landroid/util/Rational;Landroid/util/Size;)Z

    move-result p1

    return p1
.end method

.method private needToAddSensorResolutions()Z
    .locals 3

    .line 477
    invoke-direct {p0}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->getChildrenRequiredResolutions()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/util/Size;

    iget-object v2, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mFallbackAspectRatio:Landroid/util/Rational;

    .line 478
    invoke-static {v1, v2}, Landroidx/camera/core/impl/utils/AspectRatioUtil;->hasMatchingAspectRatio(Landroid/util/Size;Landroid/util/Rational;)Z

    move-result v1

    if-nez v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_1
    const/4 v0, 0x0

    return v0
.end method

.method private static removeDuplicates(Ljava/util/List;)Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;)",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;"
        }
    .end annotation

    .line 669
    invoke-interface {p0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    return-object p0

    .line 672
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    new-instance v1, Ljava/util/LinkedHashSet;

    invoke-direct {v1, p0}, Ljava/util/LinkedHashSet;-><init>(Ljava/util/Collection;)V

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    return-object v0
.end method

.method static reverseRect(Landroid/graphics/Rect;)Landroid/graphics/Rect;
    .locals 4

    .line 611
    new-instance v0, Landroid/graphics/Rect;

    iget v1, p0, Landroid/graphics/Rect;->top:I

    iget v2, p0, Landroid/graphics/Rect;->left:I

    iget v3, p0, Landroid/graphics/Rect;->bottom:I

    iget p0, p0, Landroid/graphics/Rect;->right:I

    invoke-direct {v0, v1, v2, v3, p0}, Landroid/graphics/Rect;-><init>(IIII)V

    return-object v0
.end method

.method private selectOtherAspectRatioParentResolutionsWithFovPriority(Ljava/util/List;Z)Ljava/util/List;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;Z)",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;"
        }
    .end annotation

    .line 386
    invoke-direct {p0, p1}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->groupSizesByAspectRatio(Ljava/util/List;)Ljava/util/Map;

    move-result-object p1

    .line 390
    new-instance v0, Ljava/util/ArrayList;

    invoke-interface {p1}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 391
    invoke-direct {p0, v0}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->sortByFov(Ljava/util/List;)V

    .line 395
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 396
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/util/Rational;

    .line 397
    sget-object v3, Landroidx/camera/core/impl/utils/AspectRatioUtil;->ASPECT_RATIO_16_9:Landroid/util/Rational;

    invoke-virtual {v2, v3}, Landroid/util/Rational;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    sget-object v3, Landroidx/camera/core/impl/utils/AspectRatioUtil;->ASPECT_RATIO_4_3:Landroid/util/Rational;

    invoke-virtual {v2, v3}, Landroid/util/Rational;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    goto :goto_0

    .line 401
    :cond_1
    invoke-interface {p1, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/List;

    invoke-static {v3}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/List;

    .line 402
    invoke-direct {p0, v2, v3, p2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->selectParentResolutionsByAspectRatio(Landroid/util/Rational;Ljava/util/List;Z)Ljava/util/List;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto :goto_0

    :cond_2
    return-object v1
.end method

.method private selectParentResolutions(Ljava/util/List;)Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;)",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;"
        }
    .end annotation

    .line 316
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 319
    invoke-direct {p0}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->needToAddSensorResolutions()Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    iget-object v1, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mSensorAspectRatio:Landroid/util/Rational;

    .line 320
    invoke-direct {p0, v1, p1, v2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->selectParentResolutionsByAspectRatio(Landroid/util/Rational;Ljava/util/List;Z)Ljava/util/List;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    :cond_0
    iget-object v1, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mFallbackAspectRatio:Landroid/util/Rational;

    .line 325
    invoke-direct {p0, v1, p1, v2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->selectParentResolutionsByAspectRatio(Landroid/util/Rational;Ljava/util/List;Z)Ljava/util/List;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 329
    invoke-direct {p0, p1, v2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->selectOtherAspectRatioParentResolutionsWithFovPriority(Ljava/util/List;Z)Ljava/util/List;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 332
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    const-string v2, "ResolutionsMerger"

    if-eqz v1, :cond_1

    const-string v1, "Failed to find a parent resolution that does not result in double-cropping, this might due to camera not supporting 4:3 and 16:9resolutions or a strict ResolutionSelector settings. Starting resolution selection process with resolutions that might have a smaller FOV."

    .line 337
    invoke-static {v2, v1}, Landroidx/camera/core/Logger;->w(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v1, 0x1

    .line 341
    invoke-direct {p0, p1, v1}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->selectOtherAspectRatioParentResolutionsWithFovPriority(Ljava/util/List;Z)Ljava/util/List;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 345
    :cond_1
    new-instance p1, Ljava/lang/StringBuilder;

    const-string v1, "Parent resolutions: "

    invoke-direct {p1, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v2, p1}, Landroidx/camera/core/Logger;->d(Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method

.method private selectParentResolutionsByAspectRatio(Landroid/util/Rational;Ljava/util/List;Z)Ljava/util/List;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/util/Rational;",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;Z)",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;"
        }
    .end annotation

    .line 352
    invoke-static {p1, p2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->filterResolutionsByAspectRatio(Landroid/util/Rational;Ljava/util/List;)Ljava/util/List;

    move-result-object p2

    .line 354
    invoke-static {p2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->sortInDescendingOrder(Ljava/util/List;)V

    .line 357
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0, p2}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    iget-object v1, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mChildrenConfigs:Ljava/util/Set;

    .line 358
    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroidx/camera/core/impl/UseCaseConfig;

    .line 359
    invoke-direct {p0, v2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->getSortedChildSizes(Landroidx/camera/core/impl/UseCaseConfig;)Ljava/util/List;

    move-result-object v2

    if-nez p3, :cond_0

    .line 361
    invoke-direct {p0, p1, v2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->filterOutChildSizesCausingDoubleCropping(Landroid/util/Rational;Ljava/util/List;)Ljava/util/List;

    move-result-object v2

    .line 363
    :cond_0
    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_1

    .line 366
    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    return-object p1

    .line 369
    :cond_1
    invoke-static {v2, p2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->filterOutParentSizeThatIsTooSmall(Ljava/util/Collection;Ljava/util/List;)Ljava/util/List;

    move-result-object p2

    .line 370
    invoke-static {v2, p2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->getParentSizesThatAreTooLarge(Ljava/util/Collection;Ljava/util/List;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/Set;->retainAll(Ljava/util/Collection;)Z

    goto :goto_0

    .line 374
    :cond_2
    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    .line 375
    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :cond_3
    :goto_1
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result p3

    if-eqz p3, :cond_4

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Landroid/util/Size;

    .line 376
    invoke-interface {v0, p3}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    .line 377
    invoke-interface {p1, p3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_4
    return-object p1
.end method

.method private shouldIncludeHighResolutions()Z
    .locals 3

    iget-object v0, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mChildrenConfigs:Ljava/util/Set;

    .line 283
    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/camera/core/impl/UseCaseConfig;

    .line 284
    invoke-interface {v1, v2}, Landroidx/camera/core/impl/UseCaseConfig;->isHighResolutionDisabled(Z)Z

    move-result v2

    if-eqz v2, :cond_1

    goto :goto_0

    .line 288
    :cond_1
    instance-of v2, v1, Landroidx/camera/core/impl/ImageOutputConfig;

    if-eqz v2, :cond_0

    .line 289
    check-cast v1, Landroidx/camera/core/impl/ImageOutputConfig;

    const/4 v2, 0x0

    .line 290
    invoke-interface {v1, v2}, Landroidx/camera/core/impl/ImageOutputConfig;->getResolutionSelector(Landroidx/camera/core/resolutionselector/ResolutionSelector;)Landroidx/camera/core/resolutionselector/ResolutionSelector;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 291
    invoke-virtual {v1}, Landroidx/camera/core/resolutionselector/ResolutionSelector;->getAllowedResolutionMode()I

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    :cond_2
    return v2
.end method

.method private sortByFov(Ljava/util/List;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Landroid/util/Rational;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger;->mSensorSize:Landroid/util/Size;

    .line 552
    invoke-static {v0}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->toRational(Landroid/util/Size;)Landroid/util/Rational;

    move-result-object v0

    .line 553
    new-instance v1, Landroidx/camera/core/streamsharing/ResolutionsMerger$CompareAspectRatioByOverlappingAreaToReference;

    const/4 v2, 0x1

    invoke-direct {v1, v0, v2}, Landroidx/camera/core/streamsharing/ResolutionsMerger$CompareAspectRatioByOverlappingAreaToReference;-><init>(Landroid/util/Rational;Z)V

    invoke-static {p1, v1}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    return-void
.end method

.method static sortInDescendingOrder(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;)V"
        }
    .end annotation

    .line 663
    new-instance v0, Landroidx/camera/core/impl/utils/CompareSizesByArea;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroidx/camera/core/impl/utils/CompareSizesByArea;-><init>(Z)V

    invoke-static {p0, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    return-void
.end method

.method private static toRational(Landroid/util/Size;)Landroid/util/Rational;
    .locals 2

    .line 844
    new-instance v0, Landroid/util/Rational;

    invoke-virtual {p0}, Landroid/util/Size;->getWidth()I

    move-result v1

    invoke-virtual {p0}, Landroid/util/Size;->getHeight()I

    move-result p0

    invoke-direct {v0, v1, p0}, Landroid/util/Rational;-><init>(II)V

    return-object v0
.end method

.method private static toRationalWithMod16Considered(Landroid/util/Size;)Landroid/util/Rational;
    .locals 1

    .line 833
    sget-object v0, Landroidx/camera/core/impl/utils/AspectRatioUtil;->ASPECT_RATIO_4_3:Landroid/util/Rational;

    invoke-static {p0, v0}, Landroidx/camera/core/impl/utils/AspectRatioUtil;->hasMatchingAspectRatio(Landroid/util/Size;Landroid/util/Rational;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 834
    sget-object p0, Landroidx/camera/core/impl/utils/AspectRatioUtil;->ASPECT_RATIO_4_3:Landroid/util/Rational;

    return-object p0

    .line 835
    :cond_0
    sget-object v0, Landroidx/camera/core/impl/utils/AspectRatioUtil;->ASPECT_RATIO_16_9:Landroid/util/Rational;

    invoke-static {p0, v0}, Landroidx/camera/core/impl/utils/AspectRatioUtil;->hasMatchingAspectRatio(Landroid/util/Size;Landroid/util/Rational;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 836
    sget-object p0, Landroidx/camera/core/impl/utils/AspectRatioUtil;->ASPECT_RATIO_16_9:Landroid/util/Rational;

    return-object p0

    .line 838
    :cond_1
    invoke-static {p0}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->toRational(Landroid/util/Size;)Landroid/util/Rational;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method getMergedResolutions(Landroidx/camera/core/impl/MutableConfig;)Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/camera/core/impl/MutableConfig;",
            ")",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;"
        }
    .end annotation

    .line 120
    invoke-direct {p0}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->getCameraSupportedResolutions()Ljava/util/List;

    move-result-object v0

    .line 123
    invoke-direct {p0}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->shouldIncludeHighResolutions()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 124
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, v0}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 125
    invoke-direct {p0}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->getCameraSupportedHighResolutions()Ljava/util/List;

    move-result-object v0

    invoke-interface {v1, v0}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    move-object v0, v1

    .line 130
    :cond_0
    sget-object v1, Landroidx/camera/core/impl/ImageOutputConfig;->OPTION_SUPPORTED_RESOLUTIONS:Landroidx/camera/core/impl/Config$Option;

    const/4 v2, 0x0

    .line 131
    invoke-interface {p1, v1, v2}, Landroidx/camera/core/impl/MutableConfig;->retrieveOption(Landroidx/camera/core/impl/Config$Option;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/List;

    if-eqz p1, :cond_1

    .line 133
    invoke-static {p1}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->getSupportedPrivResolutions(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    .line 136
    :cond_1
    invoke-direct {p0, v0}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->selectParentResolutions(Ljava/util/List;)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method getPreferredChildSize(Landroid/util/Size;Landroidx/camera/core/impl/UseCaseConfig;)Landroid/util/Size;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/util/Size;",
            "Landroidx/camera/core/impl/UseCaseConfig<",
            "*>;)",
            "Landroid/util/Size;"
        }
    .end annotation

    .line 218
    invoke-direct {p0, p2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->getSortedChildSizes(Landroidx/camera/core/impl/UseCaseConfig;)Ljava/util/List;

    move-result-object p2

    .line 219
    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/util/Size;

    .line 220
    invoke-direct {p0, p1, v1}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->isDoubleCropping(Landroid/util/Size;Landroid/util/Size;)Z

    move-result v2

    if-eqz v2, :cond_1

    goto :goto_0

    .line 224
    :cond_1
    invoke-static {v1, p1}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->hasUpscaling(Landroid/util/Size;Landroid/util/Size;)Z

    move-result v2

    if-nez v2, :cond_0

    return-object v1

    .line 233
    :cond_2
    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :cond_3
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/util/Size;

    .line 234
    invoke-static {v0, p1}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->hasUpscaling(Landroid/util/Size;Landroid/util/Size;)Z

    move-result v1

    if-nez v1, :cond_3

    return-object v0

    :cond_4
    return-object p1
.end method

.method getPreferredChildSizeForViewport(Landroid/util/Size;Landroidx/camera/core/impl/UseCaseConfig;)Landroid/util/Size;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/util/Size;",
            "Landroidx/camera/core/impl/UseCaseConfig<",
            "*>;)",
            "Landroid/util/Size;"
        }
    .end annotation

    .line 256
    invoke-direct {p0, p2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->getSortedChildSizes(Landroidx/camera/core/impl/UseCaseConfig;)Ljava/util/List;

    move-result-object p2

    .line 258
    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :cond_0
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/util/Size;

    .line 260
    invoke-static {v0, p1}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->getCropRectOfReferenceAspectRatio(Landroid/util/Size;Landroid/util/Size;)Landroid/graphics/Rect;

    move-result-object v0

    .line 259
    invoke-static {v0}, Landroidx/camera/core/impl/utils/TransformUtils;->rectToSize(Landroid/graphics/Rect;)Landroid/util/Size;

    move-result-object v0

    .line 262
    invoke-static {v0, p1}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->hasUpscaling(Landroid/util/Size;Landroid/util/Size;)Z

    move-result v1

    if-nez v1, :cond_0

    return-object v0

    :cond_1
    return-object p1
.end method

.method getPreferredChildSizePair(Landroidx/camera/core/impl/UseCaseConfig;Landroid/graphics/Rect;IZ)Landroid/util/Pair;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/camera/core/impl/UseCaseConfig<",
            "*>;",
            "Landroid/graphics/Rect;",
            "IZ)",
            "Landroid/util/Pair<",
            "Landroid/graphics/Rect;",
            "Landroid/util/Size;",
            ">;"
        }
    .end annotation

    .line 160
    invoke-static {p3}, Landroidx/camera/core/impl/utils/TransformUtils;->is90or270(I)Z

    move-result p3

    if-eqz p3, :cond_0

    .line 161
    invoke-static {p2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->reverseRect(Landroid/graphics/Rect;)Landroid/graphics/Rect;

    move-result-object p2

    const/4 p3, 0x1

    goto :goto_0

    :cond_0
    const/4 p3, 0x0

    .line 166
    :goto_0
    invoke-direct {p0, p2, p1, p4}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->getPreferredChildSizePairInternal(Landroid/graphics/Rect;Landroidx/camera/core/impl/UseCaseConfig;Z)Landroid/util/Pair;

    move-result-object p1

    .line 168
    iget-object p2, p1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast p2, Landroid/graphics/Rect;

    .line 169
    iget-object p1, p1, Landroid/util/Pair;->second:Ljava/lang/Object;

    check-cast p1, Landroid/util/Size;

    if-eqz p3, :cond_1

    .line 173
    invoke-static {p1}, Landroidx/camera/core/impl/utils/TransformUtils;->reverseSize(Landroid/util/Size;)Landroid/util/Size;

    move-result-object p1

    .line 174
    invoke-static {p2}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->reverseRect(Landroid/graphics/Rect;)Landroid/graphics/Rect;

    move-result-object p2

    .line 177
    :cond_1
    new-instance p3, Landroid/util/Pair;

    invoke-direct {p3, p2, p1}, Landroid/util/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    return-object p3
.end method
