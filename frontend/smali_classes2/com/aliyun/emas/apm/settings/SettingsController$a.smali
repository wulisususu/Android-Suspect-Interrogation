.class Lcom/aliyun/emas/apm/settings/SettingsController$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/settings/SettingsController;->d()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/aliyun/emas/apm/settings/SettingsController;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/settings/SettingsController;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/settings/SettingsController$a;->a:Lcom/aliyun/emas/apm/settings/SettingsController;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/settings/SettingsController$a;->a:Lcom/aliyun/emas/apm/settings/SettingsController;

    .line 1
    invoke-static {v0}, Lcom/aliyun/emas/apm/settings/SettingsController;->a(Lcom/aliyun/emas/apm/settings/SettingsController;)Lorg/json/JSONObject;

    move-result-object v0

    .line 2
    invoke-static {v0}, Lcom/aliyun/emas/apm/settings/a;->a(Lorg/json/JSONObject;)Lcom/aliyun/emas/apm/settings/Settings;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v2, p0, Lcom/aliyun/emas/apm/settings/SettingsController$a;->a:Lcom/aliyun/emas/apm/settings/SettingsController;

    .line 5
    invoke-static {v2}, Lcom/aliyun/emas/apm/settings/SettingsController;->b(Lcom/aliyun/emas/apm/settings/SettingsController;)Ljava/util/concurrent/atomic/AtomicReference;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/util/concurrent/atomic/AtomicReference;->set(Ljava/lang/Object;)V

    iget-object v2, p0, Lcom/aliyun/emas/apm/settings/SettingsController$a;->a:Lcom/aliyun/emas/apm/settings/SettingsController;

    .line 6
    invoke-static {v2}, Lcom/aliyun/emas/apm/settings/SettingsController;->c(Lcom/aliyun/emas/apm/settings/SettingsController;)Ljava/util/concurrent/atomic/AtomicReference;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/google/android/gms/tasks/TaskCompletionSource;

    invoke-virtual {v2, v1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->trySetResult(Ljava/lang/Object;)Z

    iget-object v1, p0, Lcom/aliyun/emas/apm/settings/SettingsController$a;->a:Lcom/aliyun/emas/apm/settings/SettingsController;

    .line 8
    invoke-static {v1}, Lcom/aliyun/emas/apm/settings/SettingsController;->d(Lcom/aliyun/emas/apm/settings/SettingsController;)Lcom/aliyun/emas/apm/c;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/aliyun/emas/apm/c;->a(Lorg/json/JSONObject;)V

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/settings/SettingsController$a;->a:Lcom/aliyun/emas/apm/settings/SettingsController;

    .line 11
    invoke-static {v0}, Lcom/aliyun/emas/apm/settings/SettingsController;->e(Lcom/aliyun/emas/apm/settings/SettingsController;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    :goto_0
    const-string v1, "Apm"

    const-string v2, "setting exception."

    .line 14
    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    iget-object v0, p0, Lcom/aliyun/emas/apm/settings/SettingsController$a;->a:Lcom/aliyun/emas/apm/settings/SettingsController;

    .line 15
    invoke-static {v0}, Lcom/aliyun/emas/apm/settings/SettingsController;->e(Lcom/aliyun/emas/apm/settings/SettingsController;)V

    :goto_1
    return-void
.end method
