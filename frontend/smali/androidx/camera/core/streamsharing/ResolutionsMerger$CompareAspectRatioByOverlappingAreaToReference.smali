.class Landroidx/camera/core/streamsharing/ResolutionsMerger$CompareAspectRatioByOverlappingAreaToReference;
.super Ljava/lang/Object;
.source "ResolutionsMerger.java"

# interfaces
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/camera/core/streamsharing/ResolutionsMerger;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "CompareAspectRatioByOverlappingAreaToReference"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Comparator<",
        "Landroid/util/Rational;",
        ">;"
    }
.end annotation


# instance fields
.field private final mReferenceAspectRatio:Landroid/util/Rational;

.field private final mReverse:Z


# direct methods
.method constructor <init>(Landroid/util/Rational;Z)V
    .locals 0

    .line 864
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger$CompareAspectRatioByOverlappingAreaToReference;->mReferenceAspectRatio:Landroid/util/Rational;

    iput-boolean p2, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger$CompareAspectRatioByOverlappingAreaToReference;->mReverse:Z

    return-void
.end method


# virtual methods
.method public compare(Landroid/util/Rational;Landroid/util/Rational;)I
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger$CompareAspectRatioByOverlappingAreaToReference;->mReferenceAspectRatio:Landroid/util/Rational;

    .line 871
    invoke-static {p1, v0}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->access$000(Landroid/util/Rational;Landroid/util/Rational;)F

    move-result p1

    iget-object v0, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger$CompareAspectRatioByOverlappingAreaToReference;->mReferenceAspectRatio:Landroid/util/Rational;

    .line 872
    invoke-static {p2, v0}, Landroidx/camera/core/streamsharing/ResolutionsMerger;->access$000(Landroid/util/Rational;Landroid/util/Rational;)F

    move-result p2

    iget-boolean v0, p0, Landroidx/camera/core/streamsharing/ResolutionsMerger$CompareAspectRatioByOverlappingAreaToReference;->mReverse:Z

    if-eqz v0, :cond_0

    .line 875
    invoke-static {p2, p1}, Ljava/lang/Float;->compare(FF)I

    move-result p1

    return p1

    .line 877
    :cond_0
    invoke-static {p1, p2}, Ljava/lang/Float;->compare(FF)I

    move-result p1

    return p1
.end method

.method public bridge synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x1000,
            0x1000
        }
        names = {
            null,
            null
        }
    .end annotation

    .line 856
    check-cast p1, Landroid/util/Rational;

    check-cast p2, Landroid/util/Rational;

    invoke-virtual {p0, p1, p2}, Landroidx/camera/core/streamsharing/ResolutionsMerger$CompareAspectRatioByOverlappingAreaToReference;->compare(Landroid/util/Rational;Landroid/util/Rational;)I

    move-result p1

    return p1
.end method
