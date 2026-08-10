.class public final Landroidx/camera/core/LayoutSettings$Builder;
.super Ljava/lang/Object;
.source "LayoutSettings.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/camera/core/LayoutSettings;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation


# instance fields
.field private mAlpha:F

.field private mHeight:F

.field private mOffsetX:F

.field private mOffsetY:F

.field private mWidth:F


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 112
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Landroidx/camera/core/LayoutSettings$Builder;->mAlpha:F

    const/4 v0, 0x0

    iput v0, p0, Landroidx/camera/core/LayoutSettings$Builder;->mOffsetX:F

    iput v0, p0, Landroidx/camera/core/LayoutSettings$Builder;->mOffsetY:F

    iput v0, p0, Landroidx/camera/core/LayoutSettings$Builder;->mWidth:F

    iput v0, p0, Landroidx/camera/core/LayoutSettings$Builder;->mHeight:F

    return-void
.end method


# virtual methods
.method public build()Landroidx/camera/core/LayoutSettings;
    .locals 8

    .line 187
    new-instance v7, Landroidx/camera/core/LayoutSettings;

    iget v1, p0, Landroidx/camera/core/LayoutSettings$Builder;->mAlpha:F

    iget v2, p0, Landroidx/camera/core/LayoutSettings$Builder;->mOffsetX:F

    iget v3, p0, Landroidx/camera/core/LayoutSettings$Builder;->mOffsetY:F

    iget v4, p0, Landroidx/camera/core/LayoutSettings$Builder;->mWidth:F

    iget v5, p0, Landroidx/camera/core/LayoutSettings$Builder;->mHeight:F

    const/4 v6, 0x0

    move-object v0, v7

    invoke-direct/range {v0 .. v6}, Landroidx/camera/core/LayoutSettings;-><init>(FFFFFLandroidx/camera/core/LayoutSettings$1;)V

    return-object v7
.end method

.method public setAlpha(F)Landroidx/camera/core/LayoutSettings$Builder;
    .locals 0

    iput p1, p0, Landroidx/camera/core/LayoutSettings$Builder;->mAlpha:F

    return-object p0
.end method

.method public setHeight(F)Landroidx/camera/core/LayoutSettings$Builder;
    .locals 0

    iput p1, p0, Landroidx/camera/core/LayoutSettings$Builder;->mHeight:F

    return-object p0
.end method

.method public setOffsetX(F)Landroidx/camera/core/LayoutSettings$Builder;
    .locals 0

    iput p1, p0, Landroidx/camera/core/LayoutSettings$Builder;->mOffsetX:F

    return-object p0
.end method

.method public setOffsetY(F)Landroidx/camera/core/LayoutSettings$Builder;
    .locals 0

    iput p1, p0, Landroidx/camera/core/LayoutSettings$Builder;->mOffsetY:F

    return-object p0
.end method

.method public setWidth(F)Landroidx/camera/core/LayoutSettings$Builder;
    .locals 0

    iput p1, p0, Landroidx/camera/core/LayoutSettings$Builder;->mWidth:F

    return-object p0
.end method
