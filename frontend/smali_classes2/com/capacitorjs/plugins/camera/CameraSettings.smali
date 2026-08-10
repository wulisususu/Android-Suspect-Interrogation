.class public Lcom/capacitorjs/plugins/camera/CameraSettings;
.super Ljava/lang/Object;
.source "CameraSettings.java"


# static fields
.field public static final DEFAULT_CORRECT_ORIENTATION:Z = true

.field public static final DEFAULT_QUALITY:I = 0x5a

.field public static final DEFAULT_SAVE_IMAGE_TO_GALLERY:Z = false


# instance fields
.field private allowEditing:Z

.field private height:I

.field private quality:I

.field private resultType:Lcom/capacitorjs/plugins/camera/CameraResultType;

.field private saveToGallery:Z

.field private shouldCorrectOrientation:Z

.field private shouldResize:Z

.field private source:Lcom/capacitorjs/plugins/camera/CameraSource;

.field private width:I


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 9
    sget-object v0, Lcom/capacitorjs/plugins/camera/CameraResultType;->BASE64:Lcom/capacitorjs/plugins/camera/CameraResultType;

    iput-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->resultType:Lcom/capacitorjs/plugins/camera/CameraResultType;

    const/16 v0, 0x5a

    iput v0, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->quality:I

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->shouldResize:Z

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->shouldCorrectOrientation:Z

    iput-boolean v0, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->saveToGallery:Z

    iput-boolean v0, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->allowEditing:Z

    iput v0, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->width:I

    iput v0, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->height:I

    .line 17
    sget-object v0, Lcom/capacitorjs/plugins/camera/CameraSource;->PROMPT:Lcom/capacitorjs/plugins/camera/CameraSource;

    iput-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->source:Lcom/capacitorjs/plugins/camera/CameraSource;

    return-void
.end method


# virtual methods
.method public getHeight()I
    .locals 1

    iget v0, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->height:I

    return v0
.end method

.method public getQuality()I
    .locals 1

    iget v0, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->quality:I

    return v0
.end method

.method public getResultType()Lcom/capacitorjs/plugins/camera/CameraResultType;
    .locals 1

    iget-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->resultType:Lcom/capacitorjs/plugins/camera/CameraResultType;

    return-object v0
.end method

.method public getSource()Lcom/capacitorjs/plugins/camera/CameraSource;
    .locals 1

    iget-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->source:Lcom/capacitorjs/plugins/camera/CameraSource;

    return-object v0
.end method

.method public getWidth()I
    .locals 1

    iget v0, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->width:I

    return v0
.end method

.method public isAllowEditing()Z
    .locals 1

    iget-boolean v0, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->allowEditing:Z

    return v0
.end method

.method public isSaveToGallery()Z
    .locals 1

    iget-boolean v0, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->saveToGallery:Z

    return v0
.end method

.method public isShouldCorrectOrientation()Z
    .locals 1

    iget-boolean v0, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->shouldCorrectOrientation:Z

    return v0
.end method

.method public isShouldResize()Z
    .locals 1

    iget-boolean v0, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->shouldResize:Z

    return v0
.end method

.method public setAllowEditing(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->allowEditing:Z

    return-void
.end method

.method public setHeight(I)V
    .locals 0

    iput p1, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->height:I

    return-void
.end method

.method public setQuality(I)V
    .locals 0

    iput p1, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->quality:I

    return-void
.end method

.method public setResultType(Lcom/capacitorjs/plugins/camera/CameraResultType;)V
    .locals 0

    iput-object p1, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->resultType:Lcom/capacitorjs/plugins/camera/CameraResultType;

    return-void
.end method

.method public setSaveToGallery(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->saveToGallery:Z

    return-void
.end method

.method public setShouldCorrectOrientation(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->shouldCorrectOrientation:Z

    return-void
.end method

.method public setShouldResize(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->shouldResize:Z

    return-void
.end method

.method public setSource(Lcom/capacitorjs/plugins/camera/CameraSource;)V
    .locals 0

    iput-object p1, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->source:Lcom/capacitorjs/plugins/camera/CameraSource;

    return-void
.end method

.method public setWidth(I)V
    .locals 0

    iput p1, p0, Lcom/capacitorjs/plugins/camera/CameraSettings;->width:I

    return-void
.end method
