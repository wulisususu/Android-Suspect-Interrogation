.class public Landroidx/camera/core/ResolutionInfo;
.super Ljava/lang/Object;
.source "ResolutionInfo.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/camera/core/ResolutionInfo$ResolutionInfoInternal;
    }
.end annotation


# instance fields
.field private final mResolutionInfoInternal:Landroidx/camera/core/ResolutionInfo$ResolutionInfoInternal;


# direct methods
.method public constructor <init>(Landroid/util/Size;Landroid/graphics/Rect;I)V
    .locals 1

    .line 57
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 58
    new-instance v0, Landroidx/camera/core/AutoValue_ResolutionInfo_ResolutionInfoInternal$Builder;

    invoke-direct {v0}, Landroidx/camera/core/AutoValue_ResolutionInfo_ResolutionInfoInternal$Builder;-><init>()V

    .line 60
    invoke-virtual {v0, p1}, Landroidx/camera/core/AutoValue_ResolutionInfo_ResolutionInfoInternal$Builder;->setResolution(Landroid/util/Size;)Landroidx/camera/core/ResolutionInfo$ResolutionInfoInternal$Builder;

    move-result-object p1

    .line 61
    invoke-virtual {p1, p2}, Landroidx/camera/core/ResolutionInfo$ResolutionInfoInternal$Builder;->setCropRect(Landroid/graphics/Rect;)Landroidx/camera/core/ResolutionInfo$ResolutionInfoInternal$Builder;

    move-result-object p1

    .line 62
    invoke-virtual {p1, p3}, Landroidx/camera/core/ResolutionInfo$ResolutionInfoInternal$Builder;->setRotationDegrees(I)Landroidx/camera/core/ResolutionInfo$ResolutionInfoInternal$Builder;

    move-result-object p1

    .line 63
    invoke-virtual {p1}, Landroidx/camera/core/ResolutionInfo$ResolutionInfoInternal$Builder;->build()Landroidx/camera/core/ResolutionInfo$ResolutionInfoInternal;

    move-result-object p1

    iput-object p1, p0, Landroidx/camera/core/ResolutionInfo;->mResolutionInfoInternal:Landroidx/camera/core/ResolutionInfo$ResolutionInfoInternal;

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/ResolutionInfo;->mResolutionInfoInternal:Landroidx/camera/core/ResolutionInfo$ResolutionInfoInternal;

    .line 117
    invoke-virtual {v0, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method public getCropRect()Landroid/graphics/Rect;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/ResolutionInfo;->mResolutionInfoInternal:Landroidx/camera/core/ResolutionInfo$ResolutionInfoInternal;

    .line 92
    invoke-virtual {v0}, Landroidx/camera/core/ResolutionInfo$ResolutionInfoInternal;->getCropRect()Landroid/graphics/Rect;

    move-result-object v0

    return-object v0
.end method

.method public getResolution()Landroid/util/Size;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/ResolutionInfo;->mResolutionInfoInternal:Landroidx/camera/core/ResolutionInfo$ResolutionInfoInternal;

    .line 75
    invoke-virtual {v0}, Landroidx/camera/core/ResolutionInfo$ResolutionInfoInternal;->getResolution()Landroid/util/Size;

    move-result-object v0

    return-object v0
.end method

.method public getRotationDegrees()I
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/ResolutionInfo;->mResolutionInfoInternal:Landroidx/camera/core/ResolutionInfo$ResolutionInfoInternal;

    .line 107
    invoke-virtual {v0}, Landroidx/camera/core/ResolutionInfo$ResolutionInfoInternal;->getRotationDegrees()I

    move-result v0

    return v0
.end method

.method public hashCode()I
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/ResolutionInfo;->mResolutionInfoInternal:Landroidx/camera/core/ResolutionInfo$ResolutionInfoInternal;

    .line 112
    invoke-virtual {v0}, Ljava/lang/Object;->hashCode()I

    move-result v0

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/ResolutionInfo;->mResolutionInfoInternal:Landroidx/camera/core/ResolutionInfo$ResolutionInfoInternal;

    .line 123
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
