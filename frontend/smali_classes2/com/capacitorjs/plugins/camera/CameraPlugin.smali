.class public Lcom/capacitorjs/plugins/camera/CameraPlugin;
.super Lcom/getcapacitor/Plugin;
.source "CameraPlugin.java"


# annotations
.annotation runtime Lcom/getcapacitor/annotation/CapacitorPlugin;
    name = "Camera"
    permissions = {
        .subannotation Lcom/getcapacitor/annotation/Permission;
            alias = "camera"
            strings = {
                "android.permission.CAMERA"
            }
        .end subannotation,
        .subannotation Lcom/getcapacitor/annotation/Permission;
            alias = "photos"
            strings = {}
        .end subannotation,
        .subannotation Lcom/getcapacitor/annotation/Permission;
            alias = "saveGallery"
            strings = {
                "android.permission.READ_EXTERNAL_STORAGE",
                "android.permission.WRITE_EXTERNAL_STORAGE"
            }
        .end subannotation,
        .subannotation Lcom/getcapacitor/annotation/Permission;
            alias = "readExternalStorage"
            strings = {
                "android.permission.READ_EXTERNAL_STORAGE"
            }
        .end subannotation
    }
.end annotation


# static fields
.field static final CAMERA:Ljava/lang/String; = "camera"

.field private static final IMAGE_EDIT_ERROR:Ljava/lang/String; = "Unable to edit image"

.field private static final IMAGE_FILE_SAVE_ERROR:Ljava/lang/String; = "Unable to create photo on disk"

.field private static final IMAGE_GALLERY_SAVE_ERROR:Ljava/lang/String; = "Unable to save the image in the gallery"

.field private static final IMAGE_PROCESS_NO_FILE_ERROR:Ljava/lang/String; = "Unable to process image, file not found on disk"

.field private static final INVALID_RESULT_TYPE_ERROR:Ljava/lang/String; = "Invalid resultType option"

.field private static final NO_CAMERA_ACTIVITY_ERROR:Ljava/lang/String; = "Unable to resolve camera activity"

.field private static final NO_CAMERA_ERROR:Ljava/lang/String; = "Device doesn\'t have a camera available"

.field private static final NO_PHOTO_ACTIVITY_ERROR:Ljava/lang/String; = "Unable to resolve photo activity"

.field private static final PERMISSION_DENIED_ERROR_CAMERA:Ljava/lang/String; = "User denied access to camera"

.field static final PHOTOS:Ljava/lang/String; = "photos"

.field static final READ_EXTERNAL_STORAGE:Ljava/lang/String; = "readExternalStorage"

.field static final SAVE_GALLERY:Ljava/lang/String; = "saveGallery"

.field private static final UNABLE_TO_PROCESS_IMAGE:Ljava/lang/String; = "Unable to process image"

.field private static final USER_CANCELLED:Ljava/lang/String; = "User cancelled photos app"


# instance fields
.field private imageEditedFileSavePath:Ljava/lang/String;

.field private imageFileSavePath:Ljava/lang/String;

.field private imageFileUri:Landroid/net/Uri;

.field private imagePickedContentUri:Landroid/net/Uri;

.field private isEdited:Z

.field private isFirstRequest:Z

.field private isSaved:Z

.field private final mNextLocalRequestCode:Ljava/util/concurrent/atomic/AtomicInteger;

.field private pickMedia:Landroidx/activity/result/ActivityResultLauncher;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/activity/result/ActivityResultLauncher<",
            "Landroidx/activity/result/PickVisualMediaRequest;",
            ">;"
        }
    .end annotation
.end field

.field private pickMultipleMedia:Landroidx/activity/result/ActivityResultLauncher;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/activity/result/ActivityResultLauncher<",
            "Landroidx/activity/result/PickVisualMediaRequest;",
            ">;"
        }
    .end annotation
.end field

.field private settings:Lcom/capacitorjs/plugins/camera/CameraSettings;


# direct methods
.method public static synthetic $r8$lambda$7GVo7V4Fsoje8H3_8K-lWPl3T1w(Lcom/capacitorjs/plugins/camera/CameraPlugin;Ljava/util/List;Lcom/getcapacitor/PluginCall;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->lambda$openPhotos$2(Ljava/util/List;Lcom/getcapacitor/PluginCall;)V

    return-void
.end method

.method public static synthetic $r8$lambda$7r8JnyAajpgfsettGJXQ3yH3ntU(Lcom/capacitorjs/plugins/camera/CameraPlugin;Lcom/getcapacitor/PluginCall;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->lambda$showPrompt$0(Lcom/getcapacitor/PluginCall;I)V

    return-void
.end method

.method public static synthetic $r8$lambda$Q3Zoqvz-mhUyhE9-PCNGiU94zSE(Lcom/capacitorjs/plugins/camera/CameraPlugin;Lcom/getcapacitor/PluginCall;Landroid/net/Uri;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->lambda$openPhotos$4(Lcom/getcapacitor/PluginCall;Landroid/net/Uri;)V

    return-void
.end method

.method public static synthetic $r8$lambda$fTjbhwXpo9A6PA35qcfl__8nKdQ(Lcom/capacitorjs/plugins/camera/CameraPlugin;Lcom/getcapacitor/PluginCall;Ljava/util/List;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->lambda$openPhotos$3(Lcom/getcapacitor/PluginCall;Ljava/util/List;)V

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 87
    invoke-direct {p0}, Lcom/getcapacitor/Plugin;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->isEdited:Z

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->isFirstRequest:Z

    iput-boolean v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->isSaved:Z

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->pickMultipleMedia:Landroidx/activity/result/ActivityResultLauncher;

    iput-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->pickMedia:Landroidx/activity/result/ActivityResultLauncher;

    .line 118
    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>()V

    iput-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->mNextLocalRequestCode:Ljava/util/concurrent/atomic/AtomicInteger;

    .line 120
    new-instance v0, Lcom/capacitorjs/plugins/camera/CameraSettings;

    invoke-direct {v0}, Lcom/capacitorjs/plugins/camera/CameraSettings;-><init>()V

    iput-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    return-void
.end method

.method private cameraPermissionsCallback(Lcom/getcapacitor/PluginCall;)V
    .locals 4
    .annotation runtime Lcom/getcapacitor/annotation/PermissionCallback;
    .end annotation

    .line 245
    invoke-virtual {p1}, Lcom/getcapacitor/PluginCall;->getMethodName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "pickImages"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    .line 246
    invoke-direct {p0, p1, v0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->openPhotos(Lcom/getcapacitor/PluginCall;Z)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    .line 248
    invoke-virtual {v0}, Lcom/capacitorjs/plugins/camera/CameraSettings;->getSource()Lcom/capacitorjs/plugins/camera/CameraSource;

    move-result-object v0

    sget-object v1, Lcom/capacitorjs/plugins/camera/CameraSource;->CAMERA:Lcom/capacitorjs/plugins/camera/CameraSource;

    if-ne v0, v1, :cond_1

    const-string v0, "camera"

    invoke-virtual {p0, v0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getPermissionState(Ljava/lang/String;)Lcom/getcapacitor/PermissionState;

    move-result-object v1

    sget-object v2, Lcom/getcapacitor/PermissionState;->GRANTED:Lcom/getcapacitor/PermissionState;

    if-eq v1, v2, :cond_1

    .line 249
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getLogTag()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "User denied camera permission: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getPermissionState(Ljava/lang/String;)Lcom/getcapacitor/PermissionState;

    move-result-object v0

    invoke-virtual {v0}, Lcom/getcapacitor/PermissionState;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/getcapacitor/Logger;->debug(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "User denied access to camera"

    .line 250
    invoke-virtual {p1, v0}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;)V

    return-void

    .line 253
    :cond_1
    invoke-direct {p0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->doShow(Lcom/getcapacitor/PluginCall;)V

    :goto_0
    return-void
.end method

.method private checkCameraPermissions(Lcom/getcapacitor/PluginCall;)Z
    .locals 10

    const-string v0, "camera"

    .line 202
    invoke-virtual {p0, v0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->isPermissionDeclared(Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-eqz v1, :cond_1

    .line 203
    invoke-virtual {p0, v0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getPermissionState(Ljava/lang/String;)Lcom/getcapacitor/PermissionState;

    move-result-object v4

    sget-object v5, Lcom/getcapacitor/PermissionState;->GRANTED:Lcom/getcapacitor/PermissionState;

    if-ne v4, v5, :cond_0

    goto :goto_0

    :cond_0
    move v4, v3

    goto :goto_1

    :cond_1
    :goto_0
    move v4, v2

    :goto_1
    const-string v5, "saveGallery"

    .line 204
    invoke-virtual {p0, v5}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getPermissionState(Ljava/lang/String;)Lcom/getcapacitor/PermissionState;

    move-result-object v6

    sget-object v7, Lcom/getcapacitor/PermissionState;->GRANTED:Lcom/getcapacitor/PermissionState;

    if-ne v6, v7, :cond_2

    move v6, v2

    goto :goto_2

    :cond_2
    move v6, v3

    :goto_2
    sget v7, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v8, 0x1d

    const-string v9, "cameraPermissionsCallback"

    if-lt v7, v8, :cond_4

    if-nez v4, :cond_3

    .line 211
    invoke-virtual {p0, v0, p1, v9}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->requestPermissionForAlias(Ljava/lang/String;Lcom/getcapacitor/PluginCall;Ljava/lang/String;)V

    return v3

    :cond_3
    return v2

    :cond_4
    iget-object v7, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    .line 218
    invoke-virtual {v7}, Lcom/capacitorjs/plugins/camera/CameraSettings;->isSaveToGallery()Z

    move-result v7

    if-eqz v7, :cond_7

    if-eqz v4, :cond_5

    if-nez v6, :cond_7

    :cond_5
    iget-boolean v6, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->isFirstRequest:Z

    if-eqz v6, :cond_7

    iput-boolean v3, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->isFirstRequest:Z

    if-eqz v1, :cond_6

    .line 222
    filled-new-array {v0, v5}, [Ljava/lang/String;

    move-result-object v0

    goto :goto_3

    .line 224
    :cond_6
    filled-new-array {v5}, [Ljava/lang/String;

    move-result-object v0

    .line 226
    :goto_3
    invoke-virtual {p0, v0, p1, v9}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->requestPermissionForAliases([Ljava/lang/String;Lcom/getcapacitor/PluginCall;Ljava/lang/String;)V

    return v3

    :cond_7
    if-nez v4, :cond_8

    .line 231
    invoke-virtual {p0, v0, p1, v9}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->requestPermissionForAlias(Ljava/lang/String;Lcom/getcapacitor/PluginCall;Ljava/lang/String;)V

    return v3

    :cond_8
    return v2
.end method

.method private createEditIntent(Landroid/net/Uri;)Landroid/content/Intent;
    .locals 5

    .line 862
    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-virtual {p1}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 863
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object p1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".fileprovider"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v1, v0}, Landroidx/core/content/FileProvider;->getUriForFile(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;

    move-result-object p1

    .line 864
    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.intent.action.EDIT"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v2, "image/*"

    .line 865
    invoke-virtual {v1, p1, v2}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    .line 866
    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->imageEditedFileSavePath:Ljava/lang/String;

    const/4 v0, 0x3

    .line 868
    invoke-virtual {v1, v0}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    const-string v2, "output"

    .line 869
    invoke-virtual {v1, v2, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x21

    if-lt v2, v3, :cond_0

    .line 875
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getContext()Landroid/content/Context;

    move-result-object v2

    .line 876
    invoke-virtual {v2}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v2

    const-wide/32 v3, 0x10000

    .line 877
    invoke-static {v3, v4}, Landroid/content/pm/PackageManager$ResolveInfoFlags;->of(J)Landroid/content/pm/PackageManager$ResolveInfoFlags;

    move-result-object v3

    invoke-virtual {v2, v1, v3}, Landroid/content/pm/PackageManager;->queryIntentActivities(Landroid/content/Intent;Landroid/content/pm/PackageManager$ResolveInfoFlags;)Ljava/util/List;

    move-result-object v2

    goto :goto_0

    .line 879
    :cond_0
    invoke-direct {p0, v1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->legacyQueryIntentActivities(Landroid/content/Intent;)Ljava/util/List;

    move-result-object v2

    .line 882
    :goto_0
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/content/pm/ResolveInfo;

    .line 883
    iget-object v3, v3, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;

    iget-object v3, v3, Landroid/content/pm/ActivityInfo;->packageName:Ljava/lang/String;

    .line 884
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-virtual {v4, v3, p1, v0}, Landroid/content/Context;->grantUriPermission(Ljava/lang/String;Landroid/net/Uri;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :cond_1
    return-object v1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method private deleteImageFile()V
    .locals 2

    iget-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->imageFileSavePath:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    .line 698
    invoke-virtual {v0}, Lcom/capacitorjs/plugins/camera/CameraSettings;->isSaveToGallery()Z

    move-result v0

    if-nez v0, :cond_0

    .line 699
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->imageFileSavePath:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 700
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 701
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    :cond_0
    return-void
.end method

.method private doShow(Lcom/getcapacitor/PluginCall;)V
    .locals 2

    .line 151
    sget-object v0, Lcom/capacitorjs/plugins/camera/CameraPlugin$1;->$SwitchMap$com$capacitorjs$plugins$camera$CameraSource:[I

    iget-object v1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    invoke-virtual {v1}, Lcom/capacitorjs/plugins/camera/CameraSettings;->getSource()Lcom/capacitorjs/plugins/camera/CameraSource;

    move-result-object v1

    invoke-virtual {v1}, Lcom/capacitorjs/plugins/camera/CameraSource;->ordinal()I

    move-result v1

    aget v0, v0, v1

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    .line 159
    invoke-direct {p0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->showPrompt(Lcom/getcapacitor/PluginCall;)V

    goto :goto_0

    .line 156
    :cond_0
    invoke-direct {p0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->showPhotos(Lcom/getcapacitor/PluginCall;)V

    goto :goto_0

    .line 153
    :cond_1
    invoke-direct {p0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->showCamera(Lcom/getcapacitor/PluginCall;)V

    :goto_0
    return-void
.end method

.method private editImage(Lcom/getcapacitor/PluginCall;Landroid/net/Uri;Ljava/io/ByteArrayOutputStream;)V
    .locals 1

    const-string v0, "Unable to edit image"

    .line 848
    :try_start_0
    invoke-direct {p0, p2, p3}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getTempImage(Landroid/net/Uri;Ljava/io/ByteArrayOutputStream;)Landroid/net/Uri;

    move-result-object p2

    .line 849
    invoke-direct {p0, p2}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->createEditIntent(Landroid/net/Uri;)Landroid/content/Intent;

    move-result-object p2

    if-eqz p2, :cond_0

    const-string p3, "processEditedImage"

    .line 851
    invoke-virtual {p0, p1, p2, p3}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->startActivityForResult(Lcom/getcapacitor/PluginCall;Landroid/content/Intent;Ljava/lang/String;)V

    goto :goto_0

    .line 853
    :cond_0
    invoke-virtual {p1, v0}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p2

    .line 856
    invoke-virtual {p1, v0, p2}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;Ljava/lang/Exception;)V

    :goto_0
    return-void
.end method

.method private getContractForCall(Lcom/getcapacitor/PluginCall;)Landroidx/activity/result/contract/ActivityResultContract;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/getcapacitor/PluginCall;",
            ")",
            "Landroidx/activity/result/contract/ActivityResultContract<",
            "Landroidx/activity/result/PickVisualMediaRequest;",
            "Ljava/util/List<",
            "Landroid/net/Uri;",
            ">;>;"
        }
    .end annotation

    const/4 v0, 0x0

    .line 349
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    const-string v1, "limit"

    invoke-virtual {p1, v1, v0}, Lcom/getcapacitor/PluginCall;->getInt(Ljava/lang/String;Ljava/lang/Integer;)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    const/4 v0, 0x1

    if-le p1, v0, :cond_0

    .line 351
    new-instance v0, Landroidx/activity/result/contract/ActivityResultContracts$PickMultipleVisualMedia;

    invoke-direct {v0, p1}, Landroidx/activity/result/contract/ActivityResultContracts$PickMultipleVisualMedia;-><init>(I)V

    return-object v0

    .line 353
    :cond_0
    new-instance p1, Landroidx/activity/result/contract/ActivityResultContracts$PickMultipleVisualMedia;

    invoke-direct {p1}, Landroidx/activity/result/contract/ActivityResultContracts$PickMultipleVisualMedia;-><init>()V

    return-object p1
.end method

.method private getLegacyParcelableArrayList(Landroid/os/Bundle;Ljava/lang/String;)Ljava/util/ArrayList;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/os/Bundle;",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/ArrayList<",
            "Landroid/os/Parcelable;",
            ">;"
        }
    .end annotation

    .line 459
    invoke-virtual {p1, p2}, Landroid/os/Bundle;->getParcelableArrayList(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object p1

    return-object p1
.end method

.method private getResultType(Ljava/lang/String;)Lcom/capacitorjs/plugins/camera/CameraResultType;
    .locals 3

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return-object p1

    .line 298
    :cond_0
    :try_start_0
    sget-object v0, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {p1, v0}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/capacitorjs/plugins/camera/CameraResultType;->valueOf(Ljava/lang/String;)Lcom/capacitorjs/plugins/camera/CameraResultType;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    .line 300
    :catch_0
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getLogTag()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Invalid result type \""

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, "\", defaulting to base64"

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Lcom/getcapacitor/Logger;->debug(Ljava/lang/String;Ljava/lang/String;)V

    .line 301
    sget-object p1, Lcom/capacitorjs/plugins/camera/CameraResultType;->BASE64:Lcom/capacitorjs/plugins/camera/CameraResultType;

    return-object p1
.end method

.method private getSettings(Lcom/getcapacitor/PluginCall;)Lcom/capacitorjs/plugins/camera/CameraSettings;
    .locals 5

    .line 276
    new-instance v0, Lcom/capacitorjs/plugins/camera/CameraSettings;

    invoke-direct {v0}, Lcom/capacitorjs/plugins/camera/CameraSettings;-><init>()V

    const-string v1, "resultType"

    .line 277
    invoke-virtual {p1, v1}, Lcom/getcapacitor/PluginCall;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getResultType(Ljava/lang/String;)Lcom/capacitorjs/plugins/camera/CameraResultType;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/capacitorjs/plugins/camera/CameraSettings;->setResultType(Lcom/capacitorjs/plugins/camera/CameraResultType;)V

    const/4 v1, 0x0

    .line 281
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    .line 278
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    const-string v4, "saveToGallery"

    invoke-virtual {p1, v4, v3}, Lcom/getcapacitor/PluginCall;->getBoolean(Ljava/lang/String;Ljava/lang/Boolean;)Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v4

    invoke-virtual {v0, v4}, Lcom/capacitorjs/plugins/camera/CameraSettings;->setSaveToGallery(Z)V

    const-string v4, "allowEditing"

    .line 279
    invoke-virtual {p1, v4, v3}, Lcom/getcapacitor/PluginCall;->getBoolean(Ljava/lang/String;Ljava/lang/Boolean;)Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v3

    invoke-virtual {v0, v3}, Lcom/capacitorjs/plugins/camera/CameraSettings;->setAllowEditing(Z)V

    const/16 v3, 0x5a

    .line 280
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    const-string v4, "quality"

    invoke-virtual {p1, v4, v3}, Lcom/getcapacitor/PluginCall;->getInt(Ljava/lang/String;Ljava/lang/Integer;)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    invoke-virtual {v0, v3}, Lcom/capacitorjs/plugins/camera/CameraSettings;->setQuality(I)V

    const-string v3, "width"

    .line 281
    invoke-virtual {p1, v3, v2}, Lcom/getcapacitor/PluginCall;->getInt(Ljava/lang/String;Ljava/lang/Integer;)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    invoke-virtual {v0, v3}, Lcom/capacitorjs/plugins/camera/CameraSettings;->setWidth(I)V

    const-string v3, "height"

    .line 282
    invoke-virtual {p1, v3, v2}, Lcom/getcapacitor/PluginCall;->getInt(Ljava/lang/String;Ljava/lang/Integer;)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    invoke-virtual {v0, v2}, Lcom/capacitorjs/plugins/camera/CameraSettings;->setHeight(I)V

    .line 283
    invoke-virtual {v0}, Lcom/capacitorjs/plugins/camera/CameraSettings;->getWidth()I

    move-result v2

    const/4 v3, 0x1

    if-gtz v2, :cond_0

    invoke-virtual {v0}, Lcom/capacitorjs/plugins/camera/CameraSettings;->getHeight()I

    move-result v2

    if-lez v2, :cond_1

    :cond_0
    move v1, v3

    :cond_1
    invoke-virtual {v0, v1}, Lcom/capacitorjs/plugins/camera/CameraSettings;->setShouldResize(Z)V

    const-string v1, "correctOrientation"

    .line 284
    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {p1, v1, v2}, Lcom/getcapacitor/PluginCall;->getBoolean(Ljava/lang/String;Ljava/lang/Boolean;)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    invoke-virtual {v0, v1}, Lcom/capacitorjs/plugins/camera/CameraSettings;->setShouldCorrectOrientation(Z)V

    :try_start_0
    const-string v1, "source"

    .line 286
    sget-object v2, Lcom/capacitorjs/plugins/camera/CameraSource;->PROMPT:Lcom/capacitorjs/plugins/camera/CameraSource;

    invoke-virtual {v2}, Lcom/capacitorjs/plugins/camera/CameraSource;->getSource()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1, v1, v2}, Lcom/getcapacitor/PluginCall;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/capacitorjs/plugins/camera/CameraSource;->valueOf(Ljava/lang/String;)Lcom/capacitorjs/plugins/camera/CameraSource;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/capacitorjs/plugins/camera/CameraSettings;->setSource(Lcom/capacitorjs/plugins/camera/CameraSource;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 288
    :catch_0
    sget-object p1, Lcom/capacitorjs/plugins/camera/CameraSource;->PROMPT:Lcom/capacitorjs/plugins/camera/CameraSource;

    invoke-virtual {v0, p1}, Lcom/capacitorjs/plugins/camera/CameraSettings;->setSource(Lcom/capacitorjs/plugins/camera/CameraSource;)V

    :goto_0
    return-object v0
.end method

.method private getTempFile(Landroid/net/Uri;)Ljava/io/File;
    .locals 3

    .line 594
    invoke-virtual {p1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Landroid/net/Uri;->decode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    invoke-virtual {p1}, Landroid/net/Uri;->getLastPathSegment()Ljava/lang/String;

    move-result-object p1

    const-string v0, ".jpg"

    .line 595
    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, ".jpeg"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 596
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, "."

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    new-instance v1, Ljava/util/Date;

    invoke-direct {v1}, Ljava/util/Date;-><init>()V

    invoke-virtual {v1}, Ljava/util/Date;->getTime()J

    move-result-wide v1

    invoke-virtual {p1, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 598
    :cond_0
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v0

    .line 599
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v0, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v1
.end method

.method private getTempImage(Landroid/net/Uri;Ljava/io/ByteArrayOutputStream;)Landroid/net/Uri;
    .locals 3

    const-string v0, "Unable to process image"

    const/4 v1, 0x0

    .line 726
    :try_start_0
    new-instance v2, Ljava/io/ByteArrayInputStream;

    invoke-virtual {p2}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p2

    invoke-direct {v2, p2}, Ljava/io/ByteArrayInputStream;-><init>([B)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 727
    :try_start_1
    invoke-direct {p0, p1, v2}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->saveImage(Landroid/net/Uri;Ljava/io/InputStream;)Landroid/net/Uri;

    move-result-object v1
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_3
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 731
    :try_start_2
    invoke-virtual {v2}, Ljava/io/ByteArrayInputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_2

    :catch_0
    move-exception p1

    .line 733
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getLogTag()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, v0, p1}, Lcom/getcapacitor/Logger;->error(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_2

    :catchall_0
    move-exception p1

    move-object v1, v2

    goto :goto_0

    :catchall_1
    move-exception p1

    :goto_0
    if-eqz v1, :cond_0

    .line 731
    :try_start_3
    invoke-virtual {v1}, Ljava/io/ByteArrayInputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_1

    :catch_1
    move-exception p2

    .line 733
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getLogTag()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0, p2}, Lcom/getcapacitor/Logger;->error(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 736
    :cond_0
    :goto_1
    throw p1

    :catch_2
    move-object v2, v1

    :catch_3
    if-eqz v2, :cond_1

    .line 731
    :try_start_4
    invoke-virtual {v2}, Ljava/io/ByteArrayInputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_0

    :cond_1
    :goto_2
    return-object v1
.end method

.method private synthetic lambda$openPhotos$2(Ljava/util/List;Lcom/getcapacitor/PluginCall;)V
    .locals 5

    const-string v0, "error"

    .line 368
    new-instance v1, Lcom/getcapacitor/JSObject;

    invoke-direct {v1}, Lcom/getcapacitor/JSObject;-><init>()V

    .line 369
    new-instance v2, Lcom/getcapacitor/JSArray;

    invoke-direct {v2}, Lcom/getcapacitor/JSArray;-><init>()V

    .line 370
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/net/Uri;

    .line 372
    :try_start_0
    invoke-direct {p0, v3}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->processPickedImages(Landroid/net/Uri;)Lcom/getcapacitor/JSObject;

    move-result-object v3

    .line 374
    invoke-virtual {v3, v0}, Lcom/getcapacitor/JSObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_0

    invoke-virtual {v3, v0}, Lcom/getcapacitor/JSObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_0

    .line 376
    invoke-virtual {v3, v0}, Lcom/getcapacitor/JSObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p2, v3}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;)V

    return-void

    .line 379
    :cond_0
    invoke-virtual {v2, v3}, Lcom/getcapacitor/JSArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const-string v3, "SecurityException"

    .line 382
    invoke-virtual {p2, v3}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    const-string p1, "photos"

    .line 385
    invoke-virtual {v1, p1, v2}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lcom/getcapacitor/JSObject;

    .line 386
    invoke-virtual {p2, v1}, Lcom/getcapacitor/PluginCall;->resolve(Lcom/getcapacitor/JSObject;)V

    return-void
.end method

.method private synthetic lambda$openPhotos$3(Lcom/getcapacitor/PluginCall;Ljava/util/List;)V
    .locals 2

    .line 364
    invoke-interface {p2}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 365
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    .line 366
    new-instance v1, Lcom/capacitorjs/plugins/camera/CameraPlugin$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0, p2, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin$$ExternalSyntheticLambda0;-><init>(Lcom/capacitorjs/plugins/camera/CameraPlugin;Ljava/util/List;Lcom/getcapacitor/PluginCall;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    goto :goto_0

    :cond_0
    const-string p2, "User cancelled photos app"

    .line 390
    invoke-virtual {p1, p2}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;)V

    :goto_0
    iget-object p1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->pickMultipleMedia:Landroidx/activity/result/ActivityResultLauncher;

    .line 392
    invoke-virtual {p1}, Landroidx/activity/result/ActivityResultLauncher;->unregister()V

    return-void
.end method

.method private synthetic lambda$openPhotos$4(Lcom/getcapacitor/PluginCall;Landroid/net/Uri;)V
    .locals 0

    if-eqz p2, :cond_0

    iput-object p2, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->imagePickedContentUri:Landroid/net/Uri;

    .line 405
    invoke-direct {p0, p2, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->processPickedImage(Landroid/net/Uri;Lcom/getcapacitor/PluginCall;)V

    goto :goto_0

    :cond_0
    const-string p2, "User cancelled photos app"

    .line 407
    invoke-virtual {p1, p2}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;)V

    :goto_0
    iget-object p1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->pickMedia:Landroidx/activity/result/ActivityResultLauncher;

    .line 409
    invoke-virtual {p1}, Landroidx/activity/result/ActivityResultLauncher;->unregister()V

    return-void
.end method

.method private synthetic lambda$showPrompt$0(Lcom/getcapacitor/PluginCall;I)V
    .locals 1

    if-nez p2, :cond_0

    iget-object p2, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    .line 176
    sget-object v0, Lcom/capacitorjs/plugins/camera/CameraSource;->PHOTOS:Lcom/capacitorjs/plugins/camera/CameraSource;

    invoke-virtual {p2, v0}, Lcom/capacitorjs/plugins/camera/CameraSettings;->setSource(Lcom/capacitorjs/plugins/camera/CameraSource;)V

    .line 177
    invoke-virtual {p0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->openPhotos(Lcom/getcapacitor/PluginCall;)V

    goto :goto_0

    :cond_0
    const/4 v0, 0x1

    if-ne p2, v0, :cond_1

    iget-object p2, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    .line 179
    sget-object v0, Lcom/capacitorjs/plugins/camera/CameraSource;->CAMERA:Lcom/capacitorjs/plugins/camera/CameraSource;

    invoke-virtual {p2, v0}, Lcom/capacitorjs/plugins/camera/CameraSettings;->setSource(Lcom/capacitorjs/plugins/camera/CameraSource;)V

    .line 180
    invoke-virtual {p0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->openCamera(Lcom/getcapacitor/PluginCall;)V

    :cond_1
    :goto_0
    return-void
.end method

.method static synthetic lambda$showPrompt$1(Lcom/getcapacitor/PluginCall;)V
    .locals 1

    const-string v0, "User cancelled photos app"

    .line 183
    invoke-virtual {p0, v0}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;)V

    return-void
.end method

.method private legacyQueryIntentActivities(Landroid/content/Intent;)Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Intent;",
            ")",
            "Ljava/util/List<",
            "Landroid/content/pm/ResolveInfo;",
            ">;"
        }
    .end annotation

    .line 894
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const/high16 v1, 0x10000

    invoke-virtual {v0, p1, v1}, Landroid/content/pm/PackageManager;->queryIntentActivities(Landroid/content/Intent;I)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method private openPhotos(Lcom/getcapacitor/PluginCall;Z)V
    .locals 2

    if-eqz p2, :cond_0

    .line 362
    :try_start_0
    invoke-direct {p0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getContractForCall(Lcom/getcapacitor/PluginCall;)Landroidx/activity/result/contract/ActivityResultContract;

    move-result-object p2

    new-instance v0, Lcom/capacitorjs/plugins/camera/CameraPlugin$$ExternalSyntheticLambda1;

    invoke-direct {v0, p0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin$$ExternalSyntheticLambda1;-><init>(Lcom/capacitorjs/plugins/camera/CameraPlugin;Lcom/getcapacitor/PluginCall;)V

    .line 361
    invoke-direct {p0, p2, v0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->registerActivityResultLauncher(Landroidx/activity/result/contract/ActivityResultContract;Landroidx/activity/result/ActivityResultCallback;)Landroidx/activity/result/ActivityResultLauncher;

    move-result-object p2

    iput-object p2, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->pickMultipleMedia:Landroidx/activity/result/ActivityResultLauncher;

    .line 395
    new-instance v0, Landroidx/activity/result/PickVisualMediaRequest$Builder;

    invoke-direct {v0}, Landroidx/activity/result/PickVisualMediaRequest$Builder;-><init>()V

    sget-object v1, Landroidx/activity/result/contract/ActivityResultContracts$PickVisualMedia$ImageOnly;->INSTANCE:Landroidx/activity/result/contract/ActivityResultContracts$PickVisualMedia$ImageOnly;

    .line 396
    invoke-virtual {v0, v1}, Landroidx/activity/result/PickVisualMediaRequest$Builder;->setMediaType(Landroidx/activity/result/contract/ActivityResultContracts$PickVisualMedia$VisualMediaType;)Landroidx/activity/result/PickVisualMediaRequest$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/activity/result/PickVisualMediaRequest$Builder;->build()Landroidx/activity/result/PickVisualMediaRequest;

    move-result-object v0

    .line 395
    invoke-virtual {p2, v0}, Landroidx/activity/result/ActivityResultLauncher;->launch(Ljava/lang/Object;)V

    goto :goto_0

    .line 399
    :cond_0
    new-instance p2, Landroidx/activity/result/contract/ActivityResultContracts$PickVisualMedia;

    invoke-direct {p2}, Landroidx/activity/result/contract/ActivityResultContracts$PickVisualMedia;-><init>()V

    new-instance v0, Lcom/capacitorjs/plugins/camera/CameraPlugin$$ExternalSyntheticLambda2;

    invoke-direct {v0, p0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin$$ExternalSyntheticLambda2;-><init>(Lcom/capacitorjs/plugins/camera/CameraPlugin;Lcom/getcapacitor/PluginCall;)V

    .line 400
    invoke-direct {p0, p2, v0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->registerActivityResultLauncher(Landroidx/activity/result/contract/ActivityResultContract;Landroidx/activity/result/ActivityResultCallback;)Landroidx/activity/result/ActivityResultLauncher;

    move-result-object p2

    iput-object p2, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->pickMedia:Landroidx/activity/result/ActivityResultLauncher;

    .line 412
    new-instance v0, Landroidx/activity/result/PickVisualMediaRequest$Builder;

    invoke-direct {v0}, Landroidx/activity/result/PickVisualMediaRequest$Builder;-><init>()V

    sget-object v1, Landroidx/activity/result/contract/ActivityResultContracts$PickVisualMedia$ImageOnly;->INSTANCE:Landroidx/activity/result/contract/ActivityResultContracts$PickVisualMedia$ImageOnly;

    .line 413
    invoke-virtual {v0, v1}, Landroidx/activity/result/PickVisualMediaRequest$Builder;->setMediaType(Landroidx/activity/result/contract/ActivityResultContracts$PickVisualMedia$VisualMediaType;)Landroidx/activity/result/PickVisualMediaRequest$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/activity/result/PickVisualMediaRequest$Builder;->build()Landroidx/activity/result/PickVisualMediaRequest;

    move-result-object v0

    .line 412
    invoke-virtual {p2, v0}, Landroidx/activity/result/ActivityResultLauncher;->launch(Ljava/lang/Object;)V
    :try_end_0
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const-string p2, "Unable to resolve photo activity"

    .line 417
    invoke-virtual {p1, p2}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;)V

    :goto_0
    return-void
.end method

.method private prepareBitmap(Landroid/graphics/Bitmap;Landroid/net/Uri;Lcom/capacitorjs/plugins/camera/ExifWrapper;)Landroid/graphics/Bitmap;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    iget-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    .line 749
    invoke-virtual {v0}, Lcom/capacitorjs/plugins/camera/CameraSettings;->isShouldCorrectOrientation()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 750
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0, p1, p2, p3}, Lcom/capacitorjs/plugins/camera/ImageUtils;->correctOrientation(Landroid/content/Context;Landroid/graphics/Bitmap;Landroid/net/Uri;Lcom/capacitorjs/plugins/camera/ExifWrapper;)Landroid/graphics/Bitmap;

    move-result-object p2

    .line 751
    invoke-direct {p0, p1, p2}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->replaceBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object p1

    :cond_0
    iget-object p2, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    .line 754
    invoke-virtual {p2}, Lcom/capacitorjs/plugins/camera/CameraSettings;->isShouldResize()Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p2, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    .line 755
    invoke-virtual {p2}, Lcom/capacitorjs/plugins/camera/CameraSettings;->getWidth()I

    move-result p2

    iget-object p3, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    invoke-virtual {p3}, Lcom/capacitorjs/plugins/camera/CameraSettings;->getHeight()I

    move-result p3

    invoke-static {p1, p2, p3}, Lcom/capacitorjs/plugins/camera/ImageUtils;->resize(Landroid/graphics/Bitmap;II)Landroid/graphics/Bitmap;

    move-result-object p2

    .line 756
    invoke-direct {p0, p1, p2}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->replaceBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object p1

    :cond_1
    return-object p1
.end method

.method private processEditedImage(Lcom/getcapacitor/PluginCall;Landroidx/activity/result/ActivityResult;)V
    .locals 1
    .annotation runtime Lcom/getcapacitor/annotation/ActivityCallback;
    .end annotation

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->isEdited:Z

    .line 544
    invoke-direct {p0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getSettings(Lcom/getcapacitor/PluginCall;)Lcom/capacitorjs/plugins/camera/CameraSettings;

    move-result-object v0

    iput-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    .line 545
    invoke-virtual {p2}, Landroidx/activity/result/ActivityResult;->getResultCode()I

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->imagePickedContentUri:Landroid/net/Uri;

    if-eqz v0, :cond_0

    .line 549
    invoke-direct {p0, v0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->processPickedImage(Landroid/net/Uri;Lcom/getcapacitor/PluginCall;)V

    goto :goto_0

    .line 551
    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->processCameraImage(Lcom/getcapacitor/PluginCall;Landroidx/activity/result/ActivityResult;)V

    goto :goto_0

    .line 554
    :cond_1
    invoke-virtual {p0, p1, p2}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->processPickedImage(Lcom/getcapacitor/PluginCall;Landroidx/activity/result/ActivityResult;)V

    :goto_0
    return-void
.end method

.method private processPickedImage(Landroid/net/Uri;Lcom/getcapacitor/PluginCall;)V
    .locals 3

    const-string v0, "Unable to process image"

    const/4 v1, 0x0

    .line 466
    :try_start_0
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    invoke-virtual {v2, p1}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v1

    .line 467
    invoke-static {v1}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object v2

    if-nez v2, :cond_1

    const-string p1, "Unable to process bitmap"

    .line 470
    invoke-virtual {p2, p1}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v1, :cond_0

    .line 482
    :try_start_1
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 484
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getLogTag()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, v0, p1}, Lcom/getcapacitor/Logger;->error(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_0
    :goto_0
    return-void

    .line 474
    :cond_1
    :try_start_2
    invoke-direct {p0, p2, v2, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->returnResult(Lcom/getcapacitor/PluginCall;Landroid/graphics/Bitmap;Landroid/net/Uri;)V
    :try_end_2
    .catch Ljava/lang/OutOfMemoryError; {:try_start_2 .. :try_end_2} :catch_2
    .catch Ljava/io/FileNotFoundException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-eqz v1, :cond_2

    .line 482
    :try_start_3
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_3

    goto :goto_1

    :catchall_0
    move-exception p1

    goto :goto_2

    :catch_1
    move-exception p1

    :try_start_4
    const-string v2, "No such image found"

    .line 478
    invoke-virtual {p2, v2, p1}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;Ljava/lang/Exception;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    if-eqz v1, :cond_2

    .line 482
    :try_start_5
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_3

    goto :goto_1

    :catch_2
    :try_start_6
    const-string p1, "Out of memory"

    .line 476
    invoke-virtual {p2, p1}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    if-eqz v1, :cond_2

    .line 482
    :try_start_7
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_3

    goto :goto_1

    :catch_3
    move-exception p1

    .line 484
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getLogTag()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, v0, p1}, Lcom/getcapacitor/Logger;->error(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_2
    :goto_1
    return-void

    :goto_2
    if-eqz v1, :cond_3

    .line 482
    :try_start_8
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_4

    goto :goto_3

    :catch_4
    move-exception p2

    .line 484
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getLogTag()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0, p2}, Lcom/getcapacitor/Logger;->error(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 487
    :cond_3
    :goto_3
    throw p1
.end method

.method private processPickedImages(Landroid/net/Uri;)Lcom/getcapacitor/JSObject;
    .locals 10

    const-string v0, "No such image found"

    const-string v1, "error"

    const-string v2, "Unable to process image"

    .line 492
    new-instance v3, Lcom/getcapacitor/JSObject;

    invoke-direct {v3}, Lcom/getcapacitor/JSObject;-><init>()V

    const/4 v4, 0x0

    .line 494
    :try_start_0
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-virtual {v5}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v5

    invoke-virtual {v5, p1}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v4

    .line 495
    invoke-static {v4}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object v5

    if-nez v5, :cond_1

    const-string p1, "Unable to process bitmap"

    .line 498
    invoke-virtual {v3, v1, p1}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;
    :try_end_0
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_5
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_4
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v4, :cond_0

    .line 532
    :try_start_1
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 534
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getLogTag()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, v2, p1}, Lcom/getcapacitor/Logger;->error(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_0
    :goto_0
    return-object v3

    .line 502
    :cond_1
    :try_start_2
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getContext()Landroid/content/Context;

    move-result-object v6

    invoke-static {v6, v5, p1}, Lcom/capacitorjs/plugins/camera/ImageUtils;->getExifData(Landroid/content/Context;Landroid/graphics/Bitmap;Landroid/net/Uri;)Lcom/capacitorjs/plugins/camera/ExifWrapper;

    move-result-object v6
    :try_end_2
    .catch Ljava/lang/OutOfMemoryError; {:try_start_2 .. :try_end_2} :catch_5
    .catch Ljava/io/FileNotFoundException; {:try_start_2 .. :try_end_2} :catch_4
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 504
    :try_start_3
    invoke-direct {p0, v5, p1, v6}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->prepareBitmap(Landroid/graphics/Bitmap;Landroid/net/Uri;Lcom/capacitorjs/plugins/camera/ExifWrapper;)Landroid/graphics/Bitmap;

    move-result-object v5
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2
    .catch Ljava/lang/OutOfMemoryError; {:try_start_3 .. :try_end_3} :catch_5
    .catch Ljava/io/FileNotFoundException; {:try_start_3 .. :try_end_3} :catch_4
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 510
    :try_start_4
    new-instance v7, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v7}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 511
    sget-object v8, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    iget-object v9, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    invoke-virtual {v9}, Lcom/capacitorjs/plugins/camera/CameraSettings;->getQuality()I

    move-result v9

    invoke-virtual {v5, v8, v9, v7}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    .line 513
    invoke-direct {p0, p1, v7}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getTempImage(Landroid/net/Uri;Ljava/io/ByteArrayOutputStream;)Landroid/net/Uri;

    move-result-object p1

    .line 514
    invoke-virtual {p1}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v6, v5}, Lcom/capacitorjs/plugins/camera/ExifWrapper;->copyExif(Ljava/lang/String;)V

    if-eqz p1, :cond_2

    const-string v5, "format"

    const-string v7, "jpeg"

    .line 516
    invoke-virtual {v3, v5, v7}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    const-string v5, "exif"

    .line 517
    invoke-virtual {v6}, Lcom/capacitorjs/plugins/camera/ExifWrapper;->toJson()Lcom/getcapacitor/JSObject;

    move-result-object v6

    invoke-virtual {v3, v5, v6}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lcom/getcapacitor/JSObject;

    const-string v5, "path"

    .line 518
    invoke-virtual {p1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v5, v6}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    const-string v5, "webPath"

    .line 519
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getContext()Landroid/content/Context;

    move-result-object v6

    iget-object v7, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v7}, Lcom/getcapacitor/Bridge;->getLocalUrl()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, p1}, Lcom/getcapacitor/FileUtils;->getPortablePath(Landroid/content/Context;Ljava/lang/String;Landroid/net/Uri;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v3, v5, p1}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    goto :goto_1

    .line 521
    :cond_2
    invoke-virtual {v3, v1, v2}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;
    :try_end_4
    .catch Ljava/lang/OutOfMemoryError; {:try_start_4 .. :try_end_4} :catch_5
    .catch Ljava/io/FileNotFoundException; {:try_start_4 .. :try_end_4} :catch_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    :goto_1
    if-eqz v4, :cond_3

    .line 532
    :try_start_5
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_1

    goto :goto_2

    :catch_1
    move-exception p1

    .line 534
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getLogTag()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, v2, p1}, Lcom/getcapacitor/Logger;->error(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_3
    :goto_2
    return-object v3

    .line 506
    :catch_2
    :try_start_6
    invoke-virtual {v3, v1, v2}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;
    :try_end_6
    .catch Ljava/lang/OutOfMemoryError; {:try_start_6 .. :try_end_6} :catch_5
    .catch Ljava/io/FileNotFoundException; {:try_start_6 .. :try_end_6} :catch_4
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    if-eqz v4, :cond_4

    .line 532
    :try_start_7
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_3

    goto :goto_3

    :catch_3
    move-exception p1

    .line 534
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getLogTag()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, v2, p1}, Lcom/getcapacitor/Logger;->error(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_4
    :goto_3
    return-object v3

    :catchall_0
    move-exception p1

    goto :goto_5

    :catch_4
    move-exception p1

    .line 527
    :try_start_8
    invoke-virtual {v3, v1, v0}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    .line 528
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getLogTag()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0, p1}, Lcom/getcapacitor/Logger;->error(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    if-eqz v4, :cond_5

    .line 532
    :try_start_9
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_6

    goto :goto_4

    :catch_5
    :try_start_a
    const-string p1, "Out of memory"

    .line 525
    invoke-virtual {v3, v1, p1}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    if-eqz v4, :cond_5

    .line 532
    :try_start_b
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_b
    .catch Ljava/io/IOException; {:try_start_b .. :try_end_b} :catch_6

    goto :goto_4

    :catch_6
    move-exception p1

    .line 534
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getLogTag()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, v2, p1}, Lcom/getcapacitor/Logger;->error(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_5
    :goto_4
    return-object v3

    :goto_5
    if-eqz v4, :cond_6

    .line 532
    :try_start_c
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_c
    .catch Ljava/io/IOException; {:try_start_c .. :try_end_c} :catch_7

    goto :goto_6

    :catch_7
    move-exception v0

    .line 534
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getLogTag()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v2, v0}, Lcom/getcapacitor/Logger;->error(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 537
    :cond_6
    :goto_6
    throw p1
.end method

.method private registerActivityResultLauncher(Landroidx/activity/result/contract/ActivityResultContract;Landroidx/activity/result/ActivityResultCallback;)Landroidx/activity/result/ActivityResultLauncher;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<I:",
            "Ljava/lang/Object;",
            "O:",
            "Ljava/lang/Object;",
            ">(",
            "Landroidx/activity/result/contract/ActivityResultContract<",
            "TI;TO;>;",
            "Landroidx/activity/result/ActivityResultCallback<",
            "TO;>;)",
            "Landroidx/activity/result/ActivityResultLauncher<",
            "TI;>;"
        }
    .end annotation

    .line 337
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "cap_activity_rq#"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->mNextLocalRequestCode:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicInteger;->getAndIncrement()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 338
    iget-object v1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v1}, Lcom/getcapacitor/Bridge;->getFragment()Landroidx/fragment/app/Fragment;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 339
    iget-object v1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v1}, Lcom/getcapacitor/Bridge;->getFragment()Landroidx/fragment/app/Fragment;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/fragment/app/Fragment;->getHost()Ljava/lang/Object;

    move-result-object v1

    .line 340
    instance-of v2, v1, Landroidx/activity/result/ActivityResultRegistryOwner;

    if-eqz v2, :cond_0

    .line 341
    check-cast v1, Landroidx/activity/result/ActivityResultRegistryOwner;

    invoke-interface {v1}, Landroidx/activity/result/ActivityResultRegistryOwner;->getActivityResultRegistry()Landroidx/activity/result/ActivityResultRegistry;

    move-result-object v1

    invoke-virtual {v1, v0, p1, p2}, Landroidx/activity/result/ActivityResultRegistry;->register(Ljava/lang/String;Landroidx/activity/result/contract/ActivityResultContract;Landroidx/activity/result/ActivityResultCallback;)Landroidx/activity/result/ActivityResultLauncher;

    move-result-object p1

    return-object p1

    .line 343
    :cond_0
    iget-object v1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v1}, Lcom/getcapacitor/Bridge;->getFragment()Landroidx/fragment/app/Fragment;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/fragment/app/Fragment;->requireActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/fragment/app/FragmentActivity;->getActivityResultRegistry()Landroidx/activity/result/ActivityResultRegistry;

    move-result-object v1

    invoke-virtual {v1, v0, p1, p2}, Landroidx/activity/result/ActivityResultRegistry;->register(Ljava/lang/String;Landroidx/activity/result/contract/ActivityResultContract;Landroidx/activity/result/ActivityResultCallback;)Landroidx/activity/result/ActivityResultLauncher;

    move-result-object p1

    return-object p1

    .line 345
    :cond_1
    iget-object v1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v1}, Lcom/getcapacitor/Bridge;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/appcompat/app/AppCompatActivity;->getActivityResultRegistry()Landroidx/activity/result/ActivityResultRegistry;

    move-result-object v1

    invoke-virtual {v1, v0, p1, p2}, Landroidx/activity/result/ActivityResultRegistry;->register(Ljava/lang/String;Landroidx/activity/result/contract/ActivityResultContract;Landroidx/activity/result/ActivityResultCallback;)Landroidx/activity/result/ActivityResultLauncher;

    move-result-object p1

    return-object p1
.end method

.method private replaceBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;
    .locals 0

    if-eq p1, p2, :cond_0

    .line 764
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->recycle()V

    :cond_0
    return-object p2
.end method

.method private returnBase64(Lcom/getcapacitor/PluginCall;Lcom/capacitorjs/plugins/camera/ExifWrapper;Ljava/io/ByteArrayOutputStream;)V
    .locals 3

    .line 782
    invoke-virtual {p3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p3

    const/4 v0, 0x2

    .line 783
    invoke-static {p3, v0}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object p3

    .line 785
    new-instance v0, Lcom/getcapacitor/JSObject;

    invoke-direct {v0}, Lcom/getcapacitor/JSObject;-><init>()V

    const-string v1, "format"

    const-string v2, "jpeg"

    .line 786
    invoke-virtual {v0, v1, v2}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    const-string v1, "base64String"

    .line 787
    invoke-virtual {v0, v1, p3}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    const-string p3, "exif"

    .line 788
    invoke-virtual {p2}, Lcom/capacitorjs/plugins/camera/ExifWrapper;->toJson()Lcom/getcapacitor/JSObject;

    move-result-object p2

    invoke-virtual {v0, p3, p2}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lcom/getcapacitor/JSObject;

    .line 789
    invoke-virtual {p1, v0}, Lcom/getcapacitor/PluginCall;->resolve(Lcom/getcapacitor/JSObject;)V

    return-void
.end method

.method private returnDataUrl(Lcom/getcapacitor/PluginCall;Lcom/capacitorjs/plugins/camera/ExifWrapper;Ljava/io/ByteArrayOutputStream;)V
    .locals 3

    .line 771
    invoke-virtual {p3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p3

    const/4 v0, 0x2

    .line 772
    invoke-static {p3, v0}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object p3

    .line 774
    new-instance v0, Lcom/getcapacitor/JSObject;

    invoke-direct {v0}, Lcom/getcapacitor/JSObject;-><init>()V

    const-string v1, "format"

    const-string v2, "jpeg"

    .line 775
    invoke-virtual {v0, v1, v2}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    .line 776
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "data:image/jpeg;base64,"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    const-string v1, "dataUrl"

    invoke-virtual {v0, v1, p3}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    const-string p3, "exif"

    .line 777
    invoke-virtual {p2}, Lcom/capacitorjs/plugins/camera/ExifWrapper;->toJson()Lcom/getcapacitor/JSObject;

    move-result-object p2

    invoke-virtual {v0, p3, p2}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lcom/getcapacitor/JSObject;

    .line 778
    invoke-virtual {p1, v0}, Lcom/getcapacitor/PluginCall;->resolve(Lcom/getcapacitor/JSObject;)V

    return-void
.end method

.method private returnFileURI(Lcom/getcapacitor/PluginCall;Lcom/capacitorjs/plugins/camera/ExifWrapper;Landroid/graphics/Bitmap;Landroid/net/Uri;Ljava/io/ByteArrayOutputStream;)V
    .locals 1

    .line 707
    invoke-direct {p0, p4, p5}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getTempImage(Landroid/net/Uri;Ljava/io/ByteArrayOutputStream;)Landroid/net/Uri;

    move-result-object p3

    .line 708
    invoke-virtual {p3}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object p4

    invoke-virtual {p2, p4}, Lcom/capacitorjs/plugins/camera/ExifWrapper;->copyExif(Ljava/lang/String;)V

    if-eqz p3, :cond_0

    .line 710
    new-instance p4, Lcom/getcapacitor/JSObject;

    invoke-direct {p4}, Lcom/getcapacitor/JSObject;-><init>()V

    const-string p5, "format"

    const-string v0, "jpeg"

    .line 711
    invoke-virtual {p4, p5, v0}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    const-string p5, "exif"

    .line 712
    invoke-virtual {p2}, Lcom/capacitorjs/plugins/camera/ExifWrapper;->toJson()Lcom/getcapacitor/JSObject;

    move-result-object p2

    invoke-virtual {p4, p5, p2}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lcom/getcapacitor/JSObject;

    const-string p2, "path"

    .line 713
    invoke-virtual {p3}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object p5

    invoke-virtual {p4, p2, p5}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    .line 714
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getContext()Landroid/content/Context;

    move-result-object p2

    iget-object p5, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {p5}, Lcom/getcapacitor/Bridge;->getLocalUrl()Ljava/lang/String;

    move-result-object p5

    invoke-static {p2, p5, p3}, Lcom/getcapacitor/FileUtils;->getPortablePath(Landroid/content/Context;Ljava/lang/String;Landroid/net/Uri;)Ljava/lang/String;

    move-result-object p2

    const-string p3, "webPath"

    invoke-virtual {p4, p3, p2}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    const-string p2, "saved"

    iget-boolean p3, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->isSaved:Z

    .line 715
    invoke-virtual {p4, p2, p3}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Z)Lcom/getcapacitor/JSObject;

    .line 716
    invoke-virtual {p1, p4}, Lcom/getcapacitor/PluginCall;->resolve(Lcom/getcapacitor/JSObject;)V

    goto :goto_0

    :cond_0
    const-string p2, "Unable to process image"

    .line 718
    invoke-virtual {p1, p2}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;)V

    :goto_0
    return-void
.end method

.method private returnResult(Lcom/getcapacitor/PluginCall;Landroid/graphics/Bitmap;Landroid/net/Uri;)V
    .locals 8

    .line 610
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0, p2, p3}, Lcom/capacitorjs/plugins/camera/ImageUtils;->getExifData(Landroid/content/Context;Landroid/graphics/Bitmap;Landroid/net/Uri;)Lcom/capacitorjs/plugins/camera/ExifWrapper;

    move-result-object v3

    .line 612
    :try_start_0
    invoke-direct {p0, p2, p3, v3}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->prepareBitmap(Landroid/graphics/Bitmap;Landroid/net/Uri;Lcom/capacitorjs/plugins/camera/ExifWrapper;)Landroid/graphics/Bitmap;

    move-result-object v4
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2

    .line 618
    new-instance v6, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v6}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 619
    sget-object p2, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    iget-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    invoke-virtual {v0}, Lcom/capacitorjs/plugins/camera/CameraSettings;->getQuality()I

    move-result v0

    invoke-virtual {v4, p2, v0, v6}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    iget-object p2, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    .line 621
    invoke-virtual {p2}, Lcom/capacitorjs/plugins/camera/CameraSettings;->isAllowEditing()Z

    move-result p2

    if-eqz p2, :cond_0

    iget-boolean p2, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->isEdited:Z

    if-nez p2, :cond_0

    .line 622
    invoke-direct {p0, p1, p3, v6}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->editImage(Lcom/getcapacitor/PluginCall;Landroid/net/Uri;Ljava/io/ByteArrayOutputStream;)V

    return-void

    :cond_0
    const-string p2, "saveToGallery"

    const/4 v0, 0x0

    .line 626
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {p1, p2, v1}, Lcom/getcapacitor/PluginCall;->getBoolean(Ljava/lang/String;Ljava/lang/Boolean;)Ljava/lang/Boolean;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p2

    if-eqz p2, :cond_6

    iget-object p2, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->imageEditedFileSavePath:Ljava/lang/String;

    if-nez p2, :cond_1

    iget-object v1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->imageFileSavePath:Ljava/lang/String;

    if-eqz v1, :cond_6

    :cond_1
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->isSaved:Z

    const-string v1, "Unable to save the image in the gallery"

    if-eqz p2, :cond_2

    goto :goto_0

    :cond_2
    :try_start_1
    iget-object p2, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->imageFileSavePath:Ljava/lang/String;

    .line 631
    :goto_0
    new-instance v2, Ljava/io/File;

    invoke-direct {v2, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v7, 0x1d

    if-lt v5, v7, :cond_5

    .line 634
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getContext()Landroid/content/Context;

    move-result-object p2

    invoke-virtual {p2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p2

    .line 635
    new-instance v5, Landroid/content/ContentValues;

    invoke-direct {v5}, Landroid/content/ContentValues;-><init>()V

    const-string v7, "_display_name"

    .line 636
    invoke-virtual {v2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v5, v7, v2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "mime_type"

    const-string v7, "image/jpeg"

    .line 637
    invoke-virtual {v5, v2, v7}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "relative_path"

    .line 638
    sget-object v7, Landroid/os/Environment;->DIRECTORY_DCIM:Ljava/lang/String;

    invoke-virtual {v5, v2, v7}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 640
    sget-object v2, Landroid/provider/MediaStore$Images$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    .line 641
    invoke-virtual {p2, v2, v5}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    move-result-object v2

    if-eqz v2, :cond_4

    .line 647
    invoke-virtual {p2, v2}, Landroid/content/ContentResolver;->openOutputStream(Landroid/net/Uri;)Ljava/io/OutputStream;

    move-result-object p2

    if-eqz p2, :cond_3

    .line 652
    sget-object v2, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    iget-object v5, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    invoke-virtual {v5}, Lcom/capacitorjs/plugins/camera/CameraSettings;->getQuality()I

    move-result v5

    invoke-virtual {v4, v2, v5, p2}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    move-result p2

    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p2

    .line 654
    invoke-virtual {p2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p2

    if-nez p2, :cond_6

    iput-boolean v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->isSaved:Z

    goto :goto_1

    .line 649
    :cond_3
    new-instance p2, Ljava/io/IOException;

    const-string v2, "Failed to open output stream."

    invoke-direct {p2, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p2

    .line 644
    :cond_4
    new-instance p2, Ljava/io/IOException;

    const-string v2, "Failed to create new MediaStore record."

    invoke-direct {p2, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p2

    .line 659
    :cond_5
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-virtual {v5}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v5

    .line 661
    invoke-virtual {v2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v2

    const-string v7, ""

    .line 658
    invoke-static {v5, p2, v2, v7}, Landroid/provider/MediaStore$Images$Media;->insertImage(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    if-nez p2, :cond_6

    iput-boolean v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->isSaved:Z
    :try_end_1
    .catch Ljava/io/FileNotFoundException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    :catch_0
    move-exception p2

    iput-boolean v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->isSaved:Z

    .line 674
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getLogTag()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, v1, p2}, Lcom/getcapacitor/Logger;->error(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_1

    :catch_1
    move-exception p2

    iput-boolean v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->isSaved:Z

    .line 671
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getLogTag()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, v1, p2}, Lcom/getcapacitor/Logger;->error(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_6
    :goto_1
    iget-object p2, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    .line 678
    invoke-virtual {p2}, Lcom/capacitorjs/plugins/camera/CameraSettings;->getResultType()Lcom/capacitorjs/plugins/camera/CameraResultType;

    move-result-object p2

    sget-object v0, Lcom/capacitorjs/plugins/camera/CameraResultType;->BASE64:Lcom/capacitorjs/plugins/camera/CameraResultType;

    if-ne p2, v0, :cond_7

    .line 679
    invoke-direct {p0, p1, v3, v6}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->returnBase64(Lcom/getcapacitor/PluginCall;Lcom/capacitorjs/plugins/camera/ExifWrapper;Ljava/io/ByteArrayOutputStream;)V

    goto :goto_2

    :cond_7
    iget-object p2, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    .line 680
    invoke-virtual {p2}, Lcom/capacitorjs/plugins/camera/CameraSettings;->getResultType()Lcom/capacitorjs/plugins/camera/CameraResultType;

    move-result-object p2

    sget-object v0, Lcom/capacitorjs/plugins/camera/CameraResultType;->URI:Lcom/capacitorjs/plugins/camera/CameraResultType;

    if-ne p2, v0, :cond_8

    move-object v1, p0

    move-object v2, p1

    move-object v5, p3

    .line 681
    invoke-direct/range {v1 .. v6}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->returnFileURI(Lcom/getcapacitor/PluginCall;Lcom/capacitorjs/plugins/camera/ExifWrapper;Landroid/graphics/Bitmap;Landroid/net/Uri;Ljava/io/ByteArrayOutputStream;)V

    goto :goto_2

    :cond_8
    iget-object p2, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    .line 682
    invoke-virtual {p2}, Lcom/capacitorjs/plugins/camera/CameraSettings;->getResultType()Lcom/capacitorjs/plugins/camera/CameraResultType;

    move-result-object p2

    sget-object p3, Lcom/capacitorjs/plugins/camera/CameraResultType;->DATAURL:Lcom/capacitorjs/plugins/camera/CameraResultType;

    if-ne p2, p3, :cond_9

    .line 683
    invoke-direct {p0, p1, v3, v6}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->returnDataUrl(Lcom/getcapacitor/PluginCall;Lcom/capacitorjs/plugins/camera/ExifWrapper;Ljava/io/ByteArrayOutputStream;)V

    goto :goto_2

    :cond_9
    const-string p2, "Invalid resultType option"

    .line 685
    invoke-virtual {p1, p2}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;)V

    :goto_2
    iget-object p1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    .line 688
    invoke-virtual {p1}, Lcom/capacitorjs/plugins/camera/CameraSettings;->getResultType()Lcom/capacitorjs/plugins/camera/CameraResultType;

    move-result-object p1

    sget-object p2, Lcom/capacitorjs/plugins/camera/CameraResultType;->URI:Lcom/capacitorjs/plugins/camera/CameraResultType;

    if-eq p1, p2, :cond_a

    .line 689
    invoke-direct {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->deleteImageFile()V

    :cond_a
    const/4 p1, 0x0

    iput-object p1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->imageFileSavePath:Ljava/lang/String;

    iput-object p1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->imageFileUri:Landroid/net/Uri;

    iput-object p1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->imagePickedContentUri:Landroid/net/Uri;

    iput-object p1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->imageEditedFileSavePath:Ljava/lang/String;

    return-void

    :catch_2
    const-string p2, "Unable to process image"

    .line 614
    invoke-virtual {p1, p2}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;)V

    return-void
.end method

.method private saveImage(Landroid/net/Uri;Ljava/io/InputStream;)Landroid/net/Uri;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 568
    invoke-virtual {p1}, Landroid/net/Uri;->getScheme()Ljava/lang/String;

    move-result-object v0

    const-string v1, "content"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 569
    invoke-direct {p0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getTempFile(Landroid/net/Uri;)Ljava/io/File;

    move-result-object v0

    goto :goto_0

    .line 571
    :cond_0
    new-instance v0, Ljava/io/File;

    invoke-virtual {p1}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 574
    :goto_0
    :try_start_0
    invoke-direct {p0, v0, p2}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->writePhoto(Ljava/io/File;Ljava/io/InputStream;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 577
    :catch_0
    invoke-direct {p0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getTempFile(Landroid/net/Uri;)Ljava/io/File;

    move-result-object v0

    .line 578
    invoke-direct {p0, v0, p2}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->writePhoto(Ljava/io/File;Ljava/io/InputStream;)V

    .line 580
    :goto_1
    invoke-static {v0}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object p1

    return-object p1
.end method

.method private showCamera(Lcom/getcapacitor/PluginCall;)V
    .locals 2

    .line 189
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const-string v1, "android.hardware.camera.any"

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "Device doesn\'t have a camera available"

    .line 190
    invoke-virtual {p1, v0}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;)V

    return-void

    .line 193
    :cond_0
    invoke-virtual {p0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->openCamera(Lcom/getcapacitor/PluginCall;)V

    return-void
.end method

.method private showPhotos(Lcom/getcapacitor/PluginCall;)V
    .locals 0

    .line 197
    invoke-virtual {p0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->openPhotos(Lcom/getcapacitor/PluginCall;)V

    return-void
.end method

.method private showPrompt(Lcom/getcapacitor/PluginCall;)V
    .locals 4

    .line 166
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const-string v1, "promptLabelPhoto"

    const-string v2, "From Photos"

    .line 167
    invoke-virtual {p1, v1, v2}, Lcom/getcapacitor/PluginCall;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "promptLabelPicture"

    const-string v2, "Take Picture"

    .line 168
    invoke-virtual {p1, v1, v2}, Lcom/getcapacitor/PluginCall;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 170
    new-instance v1, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;

    invoke-direct {v1}, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;-><init>()V

    const-string v2, "promptLabelHeader"

    const-string v3, "Photo"

    .line 171
    invoke-virtual {p1, v2, v3}, Lcom/getcapacitor/PluginCall;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;->setTitle(Ljava/lang/String;)V

    .line 172
    new-instance v2, Lcom/capacitorjs/plugins/camera/CameraPlugin$$ExternalSyntheticLambda3;

    invoke-direct {v2, p0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin$$ExternalSyntheticLambda3;-><init>(Lcom/capacitorjs/plugins/camera/CameraPlugin;Lcom/getcapacitor/PluginCall;)V

    new-instance v3, Lcom/capacitorjs/plugins/camera/CameraPlugin$$ExternalSyntheticLambda4;

    invoke-direct {v3, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin$$ExternalSyntheticLambda4;-><init>(Lcom/getcapacitor/PluginCall;)V

    invoke-virtual {v1, v0, v2, v3}, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;->setOptions(Ljava/util/List;Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment$BottomSheetOnSelectedListener;Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment$BottomSheetOnCanceledListener;)V

    .line 185
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object p1

    invoke-virtual {p1}, Landroidx/appcompat/app/AppCompatActivity;->getSupportFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object p1

    const-string v0, "capacitorModalsActionSheet"

    invoke-virtual {v1, p1, v0}, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;->show(Landroidx/fragment/app/FragmentManager;Ljava/lang/String;)V

    return-void
.end method

.method private writePhoto(Ljava/io/File;Ljava/io/InputStream;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 584
    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    const/16 p1, 0x400

    new-array p1, p1, [B

    .line 587
    :goto_0
    invoke-virtual {p2, p1}, Ljava/io/InputStream;->read([B)I

    move-result v1

    const/4 v2, -0x1

    if-eq v1, v2, :cond_0

    const/4 v2, 0x0

    .line 588
    invoke-virtual {v0, p1, v2, v1}, Ljava/io/FileOutputStream;->write([BII)V

    goto :goto_0

    .line 590
    :cond_0
    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V

    return-void
.end method


# virtual methods
.method public getLimitedLibraryPhotos(Lcom/getcapacitor/PluginCall;)V
    .locals 1
    .annotation runtime Lcom/getcapacitor/PluginMethod;
    .end annotation

    const-string v0, "not supported on android"

    .line 147
    invoke-virtual {p1, v0}, Lcom/getcapacitor/PluginCall;->unimplemented(Ljava/lang/String;)V

    return-void
.end method

.method public getPermissionStates()Ljava/util/Map;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/getcapacitor/PermissionState;",
            ">;"
        }
    .end annotation

    .line 824
    invoke-super {p0}, Lcom/getcapacitor/Plugin;->getPermissionStates()Ljava/util/Map;

    move-result-object v0

    const-string v1, "camera"

    .line 827
    invoke-virtual {p0, v1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->isPermissionDeclared(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 828
    sget-object v2, Lcom/getcapacitor/PermissionState;->GRANTED:Lcom/getcapacitor/PermissionState;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    const-string v1, "photos"

    .line 831
    invoke-interface {v0, v1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 832
    sget-object v2, Lcom/getcapacitor/PermissionState;->GRANTED:Lcom/getcapacitor/PermissionState;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_1
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1e

    if-lt v1, v2, :cond_2

    const-string v1, "readExternalStorage"

    .line 838
    invoke-interface {v0, v1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 839
    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/getcapacitor/PermissionState;

    const-string v2, "saveGallery"

    invoke-interface {v0, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_2
    return-object v0
.end method

.method public getPhoto(Lcom/getcapacitor/PluginCall;)V
    .locals 1
    .annotation runtime Lcom/getcapacitor/PluginMethod;
    .end annotation

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->isEdited:Z

    .line 130
    invoke-direct {p0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getSettings(Lcom/getcapacitor/PluginCall;)Lcom/capacitorjs/plugins/camera/CameraSettings;

    move-result-object v0

    iput-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    .line 131
    invoke-direct {p0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->doShow(Lcom/getcapacitor/PluginCall;)V

    return-void
.end method

.method protected handleOnDestroy()V
    .locals 1

    iget-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->pickMedia:Landroidx/activity/result/ActivityResultLauncher;

    if-eqz v0, :cond_0

    .line 920
    invoke-virtual {v0}, Landroidx/activity/result/ActivityResultLauncher;->unregister()V

    :cond_0
    iget-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->pickMultipleMedia:Landroidx/activity/result/ActivityResultLauncher;

    if-eqz v0, :cond_1

    .line 923
    invoke-virtual {v0}, Landroidx/activity/result/ActivityResultLauncher;->unregister()V

    :cond_1
    return-void
.end method

.method public load()V
    .locals 0

    .line 124
    invoke-super {p0}, Lcom/getcapacitor/Plugin;->load()V

    return-void
.end method

.method public openCamera(Lcom/getcapacitor/PluginCall;)V
    .locals 5

    .line 306
    invoke-direct {p0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->checkCameraPermissions(Lcom/getcapacitor/PluginCall;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 307
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.media.action.IMAGE_CAPTURE"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 308
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/Intent;->resolveActivity(Landroid/content/pm/PackageManager;)Landroid/content/ComponentName;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 311
    :try_start_0
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getAppId()Ljava/lang/String;

    move-result-object v1

    .line 312
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v2

    invoke-static {v2}, Lcom/capacitorjs/plugins/camera/CameraUtils;->createImageFile(Landroid/app/Activity;)Ljava/io/File;

    move-result-object v2

    .line 313
    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->imageFileSavePath:Ljava/lang/String;

    .line 315
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, ".fileprovider"

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v3, v1, v2}, Landroidx/core/content/FileProvider;->getUriForFile(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;

    move-result-object v1

    iput-object v1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->imageFileUri:Landroid/net/Uri;

    const-string v2, "output"

    .line 316
    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v1, "processCameraImage"

    .line 322
    invoke-virtual {p0, p1, v0, v1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->startActivityForResult(Lcom/getcapacitor/PluginCall;Landroid/content/Intent;Ljava/lang/String;)V

    goto :goto_0

    :catch_0
    move-exception v0

    const-string v1, "Unable to create photo on disk"

    .line 318
    invoke-virtual {p1, v1, v0}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;Ljava/lang/Exception;)V

    return-void

    :cond_0
    const-string v0, "Unable to resolve camera activity"

    .line 324
    invoke-virtual {p1, v0}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;)V

    :cond_1
    :goto_0
    return-void
.end method

.method public openPhotos(Lcom/getcapacitor/PluginCall;)V
    .locals 1

    const/4 v0, 0x0

    .line 330
    invoke-direct {p0, p1, v0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->openPhotos(Lcom/getcapacitor/PluginCall;Z)V

    return-void
.end method

.method public pickImages(Lcom/getcapacitor/PluginCall;)V
    .locals 1
    .annotation runtime Lcom/getcapacitor/PluginMethod;
    .end annotation

    .line 136
    invoke-direct {p0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getSettings(Lcom/getcapacitor/PluginCall;)Lcom/capacitorjs/plugins/camera/CameraSettings;

    move-result-object v0

    iput-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    const/4 v0, 0x1

    .line 137
    invoke-direct {p0, p1, v0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->openPhotos(Lcom/getcapacitor/PluginCall;Z)V

    return-void
.end method

.method public pickLimitedLibraryPhotos(Lcom/getcapacitor/PluginCall;)V
    .locals 1
    .annotation runtime Lcom/getcapacitor/PluginMethod;
    .end annotation

    const-string v0, "not supported on android"

    .line 142
    invoke-virtual {p1, v0}, Lcom/getcapacitor/PluginCall;->unimplemented(Ljava/lang/String;)V

    return-void
.end method

.method public processCameraImage(Lcom/getcapacitor/PluginCall;Landroidx/activity/result/ActivityResult;)V
    .locals 2
    .annotation runtime Lcom/getcapacitor/annotation/ActivityCallback;
    .end annotation

    .line 423
    invoke-direct {p0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getSettings(Lcom/getcapacitor/PluginCall;)Lcom/capacitorjs/plugins/camera/CameraSettings;

    move-result-object p2

    iput-object p2, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    iget-object p2, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->imageFileSavePath:Ljava/lang/String;

    if-nez p2, :cond_0

    const-string p2, "Unable to process image, file not found on disk"

    .line 425
    invoke-virtual {p1, p2}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;)V

    return-void

    .line 429
    :cond_0
    new-instance p2, Ljava/io/File;

    iget-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->imageFileSavePath:Ljava/lang/String;

    invoke-direct {p2, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 430
    new-instance v0, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v0}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 431
    invoke-static {p2}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object p2

    iget-object v1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->imageFileSavePath:Ljava/lang/String;

    .line 432
    invoke-static {v1, v0}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v0

    if-nez v0, :cond_1

    const-string p2, "User cancelled photos app"

    .line 435
    invoke-virtual {p1, p2}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;)V

    return-void

    .line 439
    :cond_1
    invoke-direct {p0, p1, v0, p2}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->returnResult(Lcom/getcapacitor/PluginCall;Landroid/graphics/Bitmap;Landroid/net/Uri;)V

    return-void
.end method

.method public processPickedImage(Lcom/getcapacitor/PluginCall;Landroidx/activity/result/ActivityResult;)V
    .locals 1

    .line 443
    invoke-direct {p0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->getSettings(Lcom/getcapacitor/PluginCall;)Lcom/capacitorjs/plugins/camera/CameraSettings;

    move-result-object v0

    iput-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->settings:Lcom/capacitorjs/plugins/camera/CameraSettings;

    .line 444
    invoke-virtual {p2}, Landroidx/activity/result/ActivityResult;->getData()Landroid/content/Intent;

    move-result-object p2

    if-nez p2, :cond_0

    const-string p2, "User cancelled photos app"

    .line 446
    invoke-virtual {p1, p2}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;)V

    return-void

    .line 450
    :cond_0
    invoke-virtual {p2}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object p2

    iput-object p2, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->imagePickedContentUri:Landroid/net/Uri;

    .line 454
    invoke-direct {p0, p2, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->processPickedImage(Landroid/net/Uri;Lcom/getcapacitor/PluginCall;)V

    return-void
.end method

.method protected requestPermissionForAliases([Ljava/lang/String;Lcom/getcapacitor/PluginCall;Ljava/lang/String;)V
    .locals 4

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x21

    const-string v2, "saveGallery"

    const/4 v3, 0x0

    if-lt v0, v1, :cond_1

    .line 260
    :goto_0
    array-length v0, p1

    if-ge v3, v0, :cond_3

    .line 261
    aget-object v0, p1, v3

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "photos"

    .line 262
    aput-object v0, p1, v3

    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_1
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-lt v0, v1, :cond_3

    .line 266
    :goto_1
    array-length v0, p1

    if-ge v3, v0, :cond_3

    .line 267
    aget-object v0, p1, v3

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, "readExternalStorage"

    .line 268
    aput-object v0, p1, v3

    :cond_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 272
    :cond_3
    invoke-super {p0, p1, p2, p3}, Lcom/getcapacitor/Plugin;->requestPermissionForAliases([Ljava/lang/String;Lcom/getcapacitor/PluginCall;Ljava/lang/String;)V

    return-void
.end method

.method public requestPermissions(Lcom/getcapacitor/PluginCall;)V
    .locals 4
    .annotation runtime Lcom/getcapacitor/PluginMethod;
    .end annotation

    const-string v0, "camera"

    .line 798
    invoke-virtual {p0, v0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->isPermissionDeclared(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 800
    invoke-super {p0, p1}, Lcom/getcapacitor/Plugin;->requestPermissions(Lcom/getcapacitor/PluginCall;)V

    goto :goto_1

    :cond_0
    const-string v1, "permissions"

    .line 804
    invoke-virtual {p1, v1}, Lcom/getcapacitor/PluginCall;->getArray(Ljava/lang/String;)Lcom/getcapacitor/JSArray;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 808
    :try_start_0
    invoke-virtual {v1}, Lcom/getcapacitor/JSArray;->toList()Ljava/util/List;

    move-result-object v1
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_1
    const/4 v1, 0x0

    :goto_0
    if-eqz v1, :cond_3

    .line 812
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v2

    const/4 v3, 0x1

    if-ne v2, v3, :cond_3

    invoke-interface {v1, v0}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    const-string v0, "photos"

    invoke-interface {v1, v0}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 814
    :cond_2
    invoke-virtual {p0, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->checkPermissions(Lcom/getcapacitor/PluginCall;)V

    goto :goto_1

    :cond_3
    const-string v0, "saveGallery"

    const-string v1, "checkPermissions"

    .line 817
    invoke-virtual {p0, v0, p1, v1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->requestPermissionForAlias(Ljava/lang/String;Lcom/getcapacitor/PluginCall;Ljava/lang/String;)V

    :goto_1
    return-void
.end method

.method protected restoreState(Landroid/os/Bundle;)V
    .locals 1

    const-string v0, "cameraImageFileSavePath"

    .line 908
    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->imageFileSavePath:Ljava/lang/String;

    :cond_0
    return-void
.end method

.method protected saveInstanceState()Landroid/os/Bundle;
    .locals 3

    .line 899
    invoke-super {p0}, Lcom/getcapacitor/Plugin;->saveInstanceState()Landroid/os/Bundle;

    move-result-object v0

    if-eqz v0, :cond_0

    const-string v1, "cameraImageFileSavePath"

    iget-object v2, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin;->imageFileSavePath:Ljava/lang/String;

    .line 901
    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-object v0
.end method
