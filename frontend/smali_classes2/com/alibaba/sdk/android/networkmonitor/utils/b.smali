.class public Lcom/alibaba/sdk/android/networkmonitor/utils/b;
.super Ljava/lang/Object;
.source "Global.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/sdk/android/networkmonitor/utils/b$b;
    }
.end annotation


# instance fields
.field private volatile a:Landroid/os/Handler;


# direct methods
.method private constructor <init>()V
    .locals 2

    .line 2
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 3
    new-instance v0, Landroid/os/HandlerThread;

    const-string v1, "Network-Monitor-Biz"

    invoke-direct {v0, v1}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V

    .line 4
    invoke-virtual {v0}, Landroid/os/HandlerThread;->start()V

    .line 5
    new-instance v1, Landroid/os/Handler;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-direct {v1, v0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a:Landroid/os/Handler;

    return-void
.end method

.method synthetic constructor <init>(Lcom/alibaba/sdk/android/networkmonitor/utils/b$a;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;-><init>()V

    return-void
.end method

.method public static a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;
    .locals 1

    .line 1
    sget-object v0, Lcom/alibaba/sdk/android/networkmonitor/utils/b$b;->a:Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    return-object v0
.end method


# virtual methods
.method public a()Landroid/os/Handler;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a:Landroid/os/Handler;

    return-object v0
.end method
