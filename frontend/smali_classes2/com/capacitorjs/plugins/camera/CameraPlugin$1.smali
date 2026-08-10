.class synthetic Lcom/capacitorjs/plugins/camera/CameraPlugin$1;
.super Ljava/lang/Object;
.source "CameraPlugin.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/capacitorjs/plugins/camera/CameraPlugin;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1008
    name = null
.end annotation


# static fields
.field static final synthetic $SwitchMap$com$capacitorjs$plugins$camera$CameraSource:[I


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 151
    invoke-static {}, Lcom/capacitorjs/plugins/camera/CameraSource;->values()[Lcom/capacitorjs/plugins/camera/CameraSource;

    move-result-object v0

    array-length v0, v0

    new-array v0, v0, [I

    sput-object v0, Lcom/capacitorjs/plugins/camera/CameraPlugin$1;->$SwitchMap$com$capacitorjs$plugins$camera$CameraSource:[I

    :try_start_0
    sget-object v1, Lcom/capacitorjs/plugins/camera/CameraSource;->CAMERA:Lcom/capacitorjs/plugins/camera/CameraSource;

    invoke-virtual {v1}, Lcom/capacitorjs/plugins/camera/CameraSource;->ordinal()I

    move-result v1

    const/4 v2, 0x1

    aput v2, v0, v1
    :try_end_0
    .catch Ljava/lang/NoSuchFieldError; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    sget-object v0, Lcom/capacitorjs/plugins/camera/CameraPlugin$1;->$SwitchMap$com$capacitorjs$plugins$camera$CameraSource:[I

    sget-object v1, Lcom/capacitorjs/plugins/camera/CameraSource;->PHOTOS:Lcom/capacitorjs/plugins/camera/CameraSource;

    invoke-virtual {v1}, Lcom/capacitorjs/plugins/camera/CameraSource;->ordinal()I

    move-result v1

    const/4 v2, 0x2

    aput v2, v0, v1
    :try_end_1
    .catch Ljava/lang/NoSuchFieldError; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method
