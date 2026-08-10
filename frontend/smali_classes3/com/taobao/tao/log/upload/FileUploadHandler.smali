.class public Lcom/taobao/tao/log/upload/FileUploadHandler;
.super Ljava/lang/Object;
.source "FileUploadHandler.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/tao/log/upload/FileUploadHandler$FileUploadHandlerHolder;
    }
.end annotation


# static fields
.field private static final POSITIVE_MSG:I = 0x1

.field private static final PULL_MSG:I = 0x0

.field private static TAG:Ljava/lang/String; = "TLOG.FileUploadHandler"


# instance fields
.field private mHandler:Landroid/os/Handler;

.field private mHandlerThread:Landroid/os/HandlerThread;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method private constructor <init>()V
    .locals 3

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 21
    new-instance v0, Landroid/os/HandlerThread;

    const-string v1, "tlog_msg_handler"

    const/16 v2, 0x13

    invoke-direct {v0, v1, v2}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;I)V

    iput-object v0, p0, Lcom/taobao/tao/log/upload/FileUploadHandler;->mHandlerThread:Landroid/os/HandlerThread;

    .line 22
    invoke-virtual {v0}, Landroid/os/HandlerThread;->start()V

    .line 23
    new-instance v0, Lcom/taobao/tao/log/upload/FileUploadHandler$1;

    iget-object v1, p0, Lcom/taobao/tao/log/upload/FileUploadHandler;->mHandlerThread:Landroid/os/HandlerThread;

    invoke-virtual {v1}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, p0, v1}, Lcom/taobao/tao/log/upload/FileUploadHandler$1;-><init>(Lcom/taobao/tao/log/upload/FileUploadHandler;Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/taobao/tao/log/upload/FileUploadHandler;->mHandler:Landroid/os/Handler;

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/tao/log/upload/FileUploadHandler$1;)V
    .locals 0

    .line 12
    invoke-direct {p0}, Lcom/taobao/tao/log/upload/FileUploadHandler;-><init>()V

    return-void
.end method

.method static synthetic access$000()Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/taobao/tao/log/upload/FileUploadHandler;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static getInstance()Lcom/taobao/tao/log/upload/FileUploadHandler;
    .locals 1

    .line 47
    invoke-static {}, Lcom/taobao/tao/log/upload/FileUploadHandler$FileUploadHandlerHolder;->access$100()Lcom/taobao/tao/log/upload/FileUploadHandler;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public sendPositiveMsg(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/tao/log/upload/FileUploadHandler;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x1

    .line 55
    invoke-static {v0, v1, p1}, Landroid/os/Message;->obtain(Landroid/os/Handler;ILjava/lang/Object;)Landroid/os/Message;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    return-void
.end method

.method public sendPullMsg()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/tao/log/upload/FileUploadHandler;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x0

    .line 51
    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    return-void
.end method
