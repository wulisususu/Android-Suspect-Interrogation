.class public abstract Landroidx/camera/core/impl/OutputSurfaceConfiguration;
.super Ljava/lang/Object;
.source "OutputSurfaceConfiguration.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static create(Landroidx/camera/core/impl/OutputSurface;Landroidx/camera/core/impl/OutputSurface;Landroidx/camera/core/impl/OutputSurface;Landroidx/camera/core/impl/OutputSurface;)Landroidx/camera/core/impl/OutputSurfaceConfiguration;
    .locals 1

    .line 38
    new-instance v0, Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;

    invoke-direct {v0, p0, p1, p2, p3}, Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;-><init>(Landroidx/camera/core/impl/OutputSurface;Landroidx/camera/core/impl/OutputSurface;Landroidx/camera/core/impl/OutputSurface;Landroidx/camera/core/impl/OutputSurface;)V

    return-object v0
.end method


# virtual methods
.method public abstract getImageAnalysisOutputSurface()Landroidx/camera/core/impl/OutputSurface;
.end method

.method public abstract getImageCaptureOutputSurface()Landroidx/camera/core/impl/OutputSurface;
.end method

.method public abstract getPostviewOutputSurface()Landroidx/camera/core/impl/OutputSurface;
.end method

.method public abstract getPreviewOutputSurface()Landroidx/camera/core/impl/OutputSurface;
.end method
