.class Lanet/channel/detect/g;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Lanet/channel/detect/f;


# direct methods
.method constructor <init>(Lanet/channel/detect/f;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/detect/g;->a:Lanet/channel/detect/f;

    .line 117
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    iget-object v0, p0, Lanet/channel/detect/g;->a:Lanet/channel/detect/f;

    .line 120
    iget-object v0, v0, Lanet/channel/detect/f;->a:Lanet/channel/detect/d;

    .line 1053
    invoke-virtual {v0}, Lanet/channel/detect/d;->a()V

    return-void
.end method
