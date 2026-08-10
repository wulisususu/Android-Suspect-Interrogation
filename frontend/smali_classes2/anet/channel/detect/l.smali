.class Lanet/channel/detect/l;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/status/NetworkStatusHelper$INetworkStatusChangeListener;


# instance fields
.field final synthetic a:Lanet/channel/detect/k;


# direct methods
.method constructor <init>(Lanet/channel/detect/k;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/detect/l;->a:Lanet/channel/detect/k;

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onNetworkStatusChanged(Lanet/channel/status/NetworkStatusHelper$NetworkStatus;)V
    .locals 1

    .line 48
    new-instance v0, Lanet/channel/detect/m;

    invoke-direct {v0, p0, p1}, Lanet/channel/detect/m;-><init>(Lanet/channel/detect/l;Lanet/channel/status/NetworkStatusHelper$NetworkStatus;)V

    invoke-static {v0}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitDetectTask(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    return-void
.end method
