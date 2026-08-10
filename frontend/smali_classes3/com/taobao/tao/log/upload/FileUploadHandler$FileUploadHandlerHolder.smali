.class Lcom/taobao/tao/log/upload/FileUploadHandler$FileUploadHandlerHolder;
.super Ljava/lang/Object;
.source "FileUploadHandler.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/tao/log/upload/FileUploadHandler;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "FileUploadHandlerHolder"
.end annotation


# static fields
.field private static handler:Lcom/taobao/tao/log/upload/FileUploadHandler;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 59
    new-instance v0, Lcom/taobao/tao/log/upload/FileUploadHandler;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/taobao/tao/log/upload/FileUploadHandler;-><init>(Lcom/taobao/tao/log/upload/FileUploadHandler$1;)V

    sput-object v0, Lcom/taobao/tao/log/upload/FileUploadHandler$FileUploadHandlerHolder;->handler:Lcom/taobao/tao/log/upload/FileUploadHandler;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 58
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$100()Lcom/taobao/tao/log/upload/FileUploadHandler;
    .locals 1

    sget-object v0, Lcom/taobao/tao/log/upload/FileUploadHandler$FileUploadHandlerHolder;->handler:Lcom/taobao/tao/log/upload/FileUploadHandler;

    return-object v0
.end method
