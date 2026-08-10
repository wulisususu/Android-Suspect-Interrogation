.class Lcom/alibaba/sdk/android/emas/EmasSender$a;
.super Landroid/os/Handler;
.source "EmasSender.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/sdk/android/emas/EmasSender;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation


# instance fields
.field private final a:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lcom/alibaba/sdk/android/emas/EmasSender;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/os/Looper;Lcom/alibaba/sdk/android/emas/EmasSender;)V
    .locals 0

    .line 177
    invoke-direct {p0, p1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 178
    new-instance p1, Ljava/lang/ref/WeakReference;

    invoke-direct {p1, p2}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object p1, p0, Lcom/alibaba/sdk/android/emas/EmasSender$a;->a:Ljava/lang/ref/WeakReference;

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 2

    .line 183
    invoke-super {p0, p1}, Landroid/os/Handler;->handleMessage(Landroid/os/Message;)V

    .line 184
    iget v0, p1, Landroid/os/Message;->what:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_3

    .line 186
    :try_start_0
    iget-object p1, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast p1, Lcom/alibaba/sdk/android/emas/g;

    if-nez p1, :cond_0

    const-string p1, "EmasSender EmasHandler singleLog is null"

    .line 188
    invoke-static {p1}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->d(Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/EmasSender$a;->a:Ljava/lang/ref/WeakReference;

    .line 192
    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/alibaba/sdk/android/emas/EmasSender;

    if-nez v0, :cond_1

    const-string p1, "EmasSender EmasHandler weakRef sender get null"

    .line 194
    invoke-static {p1}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->d(Ljava/lang/String;)V

    return-void

    .line 198
    :cond_1
    invoke-static {v0}, Lcom/alibaba/sdk/android/emas/EmasSender;->access$2200(Lcom/alibaba/sdk/android/emas/EmasSender;)Lcom/alibaba/sdk/android/emas/c;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 199
    invoke-static {v0}, Lcom/alibaba/sdk/android/emas/EmasSender;->access$2200(Lcom/alibaba/sdk/android/emas/EmasSender;)Lcom/alibaba/sdk/android/emas/c;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/emas/c;->a(Lcom/alibaba/sdk/android/emas/g;)V

    goto :goto_0

    .line 201
    :cond_2
    invoke-static {v0}, Lcom/alibaba/sdk/android/emas/EmasSender;->access$2300(Lcom/alibaba/sdk/android/emas/EmasSender;)Lcom/alibaba/sdk/android/emas/j;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/emas/j;->b(Lcom/alibaba/sdk/android/emas/g;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const-string p1, "EmasSender EmasHandler error:"

    .line 204
    invoke-static {p1}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    const-string p1, "EmasSender unknown msg"

    .line 207
    invoke-static {p1}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;)V

    :goto_0
    return-void
.end method
