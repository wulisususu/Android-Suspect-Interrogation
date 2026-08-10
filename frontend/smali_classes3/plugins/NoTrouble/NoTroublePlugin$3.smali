.class Lplugins/NoTrouble/NoTroublePlugin$3;
.super Ljava/lang/Object;
.source "NoTroublePlugin.java"

# interfaces
.implements Lcom/alibaba/sdk/android/push/CommonCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lplugins/NoTrouble/NoTroublePlugin;->setNotificationConfig(Lcom/getcapacitor/PluginCall;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lplugins/NoTrouble/NoTroublePlugin;

.field final synthetic val$future:Ljava/util/concurrent/CompletableFuture;


# direct methods
.method constructor <init>(Lplugins/NoTrouble/NoTroublePlugin;Ljava/util/concurrent/CompletableFuture;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    iput-object p1, p0, Lplugins/NoTrouble/NoTroublePlugin$3;->this$0:Lplugins/NoTrouble/NoTroublePlugin;

    iput-object p2, p0, Lplugins/NoTrouble/NoTroublePlugin$3;->val$future:Ljava/util/concurrent/CompletableFuture;

    .line 239
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailed(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iget-object p1, p0, Lplugins/NoTrouble/NoTroublePlugin$3;->this$0:Lplugins/NoTrouble/NoTroublePlugin;

    .line 248
    iget-object p1, p1, Lplugins/NoTrouble/NoTroublePlugin;->pushChannelOpenedData:Landroidx/lifecycle/MutableLiveData;

    const/4 p2, 0x1

    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroidx/lifecycle/MutableLiveData;->setValue(Ljava/lang/Object;)V

    iget-object p1, p0, Lplugins/NoTrouble/NoTroublePlugin$3;->val$future:Ljava/util/concurrent/CompletableFuture;

    .line 249
    invoke-virtual {p1, p2}, Ljava/util/concurrent/CompletableFuture;->complete(Ljava/lang/Object;)Z

    return-void
.end method

.method public onSuccess(Ljava/lang/String;)V
    .locals 1

    iget-object p1, p0, Lplugins/NoTrouble/NoTroublePlugin$3;->this$0:Lplugins/NoTrouble/NoTroublePlugin;

    .line 242
    iget-object p1, p1, Lplugins/NoTrouble/NoTroublePlugin;->pushChannelOpenedData:Landroidx/lifecycle/MutableLiveData;

    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroidx/lifecycle/MutableLiveData;->setValue(Ljava/lang/Object;)V

    iget-object p1, p0, Lplugins/NoTrouble/NoTroublePlugin$3;->val$future:Ljava/util/concurrent/CompletableFuture;

    const/4 v0, 0x1

    .line 243
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/util/concurrent/CompletableFuture;->complete(Ljava/lang/Object;)Z

    return-void
.end method
