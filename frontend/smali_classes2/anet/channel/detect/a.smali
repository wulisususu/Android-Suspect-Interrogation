.class Lanet/channel/detect/a;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/status/NetworkStatusHelper$INetworkStatusChangeListener;


# instance fields
.field final synthetic a:Lanet/channel/detect/ExceptionDetector;


# direct methods
.method constructor <init>(Lanet/channel/detect/ExceptionDetector;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/detect/a;->a:Lanet/channel/detect/ExceptionDetector;

    .line 57
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onNetworkStatusChanged(Lanet/channel/status/NetworkStatusHelper$NetworkStatus;)V
    .locals 0

    .line 60
    new-instance p1, Lanet/channel/detect/b;

    invoke-direct {p1, p0}, Lanet/channel/detect/b;-><init>(Lanet/channel/detect/a;)V

    invoke-static {p1}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitDetectTask(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    return-void
.end method
