.class Lio/ionic/starter/MainActivity$1;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/ionic/starter/MainActivity;->startWebViewRefreshLoop(Landroid/webkit/WebView;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/ionic/starter/MainActivity;

.field final synthetic val$handler:Landroid/os/Handler;

.field final synthetic val$webView:Landroid/webkit/WebView;


# direct methods
.method constructor <init>(Lio/ionic/starter/MainActivity;Landroid/webkit/WebView;Landroid/os/Handler;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    iput-object p1, p0, Lio/ionic/starter/MainActivity$1;->this$0:Lio/ionic/starter/MainActivity;

    iput-object p2, p0, Lio/ionic/starter/MainActivity$1;->val$webView:Landroid/webkit/WebView;

    iput-object p3, p0, Lio/ionic/starter/MainActivity$1;->val$handler:Landroid/os/Handler;

    .line 73
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lio/ionic/starter/MainActivity$1;->val$webView:Landroid/webkit/WebView;

    .line 76
    invoke-virtual {v0}, Landroid/webkit/WebView;->invalidate()V

    iget-object v0, p0, Lio/ionic/starter/MainActivity$1;->val$handler:Landroid/os/Handler;

    const-wide/16 v1, 0x10

    .line 77
    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method
