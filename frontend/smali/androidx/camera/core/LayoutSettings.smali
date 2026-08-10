.class public Landroidx/camera/core/LayoutSettings;
.super Ljava/lang/Object;
.source "LayoutSettings.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/camera/core/LayoutSettings$Builder;
    }
.end annotation


# static fields
.field public static final DEFAULT:Landroidx/camera/core/LayoutSettings;


# instance fields
.field private final mAlpha:F

.field private final mHeight:F

.field private final mOffsetX:F

.field private final mOffsetY:F

.field private final mWidth:F


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 31
    new-instance v0, Landroidx/camera/core/LayoutSettings$Builder;

    invoke-direct {v0}, Landroidx/camera/core/LayoutSettings$Builder;-><init>()V

    const/high16 v1, 0x3f800000    # 1.0f

    .line 32
    invoke-virtual {v0, v1}, Landroidx/camera/core/LayoutSettings$Builder;->setAlpha(F)Landroidx/camera/core/LayoutSettings$Builder;

    move-result-object v0

    const/4 v2, 0x0

    .line 33
    invoke-virtual {v0, v2}, Landroidx/camera/core/LayoutSettings$Builder;->setOffsetX(F)Landroidx/camera/core/LayoutSettings$Builder;

    move-result-object v0

    .line 34
    invoke-virtual {v0, v2}, Landroidx/camera/core/LayoutSettings$Builder;->setOffsetY(F)Landroidx/camera/core/LayoutSettings$Builder;

    move-result-object v0

    .line 35
    invoke-virtual {v0, v1}, Landroidx/camera/core/LayoutSettings$Builder;->setWidth(F)Landroidx/camera/core/LayoutSettings$Builder;

    move-result-object v0

    .line 36
    invoke-virtual {v0, v1}, Landroidx/camera/core/LayoutSettings$Builder;->setHeight(F)Landroidx/camera/core/LayoutSettings$Builder;

    move-result-object v0

    .line 37
    invoke-virtual {v0}, Landroidx/camera/core/LayoutSettings$Builder;->build()Landroidx/camera/core/LayoutSettings;

    move-result-object v0

    sput-object v0, Landroidx/camera/core/LayoutSettings;->DEFAULT:Landroidx/camera/core/LayoutSettings;

    return-void
.end method

.method private constructor <init>(FFFFF)V
    .locals 0

    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Landroidx/camera/core/LayoutSettings;->mAlpha:F

    iput p2, p0, Landroidx/camera/core/LayoutSettings;->mOffsetX:F

    iput p3, p0, Landroidx/camera/core/LayoutSettings;->mOffsetY:F

    iput p4, p0, Landroidx/camera/core/LayoutSettings;->mWidth:F

    iput p5, p0, Landroidx/camera/core/LayoutSettings;->mHeight:F

    return-void
.end method

.method synthetic constructor <init>(FFFFFLandroidx/camera/core/LayoutSettings$1;)V
    .locals 0

    .line 29
    invoke-direct/range {p0 .. p5}, Landroidx/camera/core/LayoutSettings;-><init>(FFFFF)V

    return-void
.end method


# virtual methods
.method public getAlpha()F
    .locals 1

    iget v0, p0, Landroidx/camera/core/LayoutSettings;->mAlpha:F

    return v0
.end method

.method public getHeight()F
    .locals 1

    iget v0, p0, Landroidx/camera/core/LayoutSettings;->mHeight:F

    return v0
.end method

.method public getOffsetX()F
    .locals 1

    iget v0, p0, Landroidx/camera/core/LayoutSettings;->mOffsetX:F

    return v0
.end method

.method public getOffsetY()F
    .locals 1

    iget v0, p0, Landroidx/camera/core/LayoutSettings;->mOffsetY:F

    return v0
.end method

.method public getWidth()F
    .locals 1

    iget v0, p0, Landroidx/camera/core/LayoutSettings;->mWidth:F

    return v0
.end method
