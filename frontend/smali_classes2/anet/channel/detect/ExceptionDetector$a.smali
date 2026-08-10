.class Lanet/channel/detect/ExceptionDetector$a;
.super Ljava/lang/Object;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lanet/channel/detect/ExceptionDetector;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field a:Ljava/lang/String;

.field b:Ljava/lang/String;

.field c:Ljava/lang/String;

.field d:Ljava/util/concurrent/Future;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/Future<",
            "Lorg/android/netutil/PingResponse;",
            ">;"
        }
    .end annotation
.end field

.field e:Ljava/util/concurrent/Future;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/Future<",
            "Lorg/android/netutil/PingResponse;",
            ">;"
        }
    .end annotation
.end field

.field f:Ljava/util/concurrent/Future;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/Future<",
            "Lorg/android/netutil/PingResponse;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic g:Lanet/channel/detect/ExceptionDetector;


# direct methods
.method private constructor <init>(Lanet/channel/detect/ExceptionDetector;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/detect/ExceptionDetector$a;->g:Lanet/channel/detect/ExceptionDetector;

    .line 351
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lanet/channel/detect/ExceptionDetector;Lanet/channel/detect/a;)V
    .locals 0

    .line 351
    invoke-direct {p0, p1}, Lanet/channel/detect/ExceptionDetector$a;-><init>(Lanet/channel/detect/ExceptionDetector;)V

    return-void
.end method
