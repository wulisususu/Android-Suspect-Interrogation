.class Lcom/aliyun/emas/apm/crash/l$c;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/crash/l;->c(Lcom/aliyun/emas/apm/crash/x0;Lcom/aliyun/emas/apm/settings/SettingProvider;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/aliyun/emas/apm/crash/x0;

.field final synthetic b:Lcom/aliyun/emas/apm/settings/SettingProvider;

.field final synthetic c:Lcom/aliyun/emas/apm/crash/l;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/crash/l;Lcom/aliyun/emas/apm/crash/x0;Lcom/aliyun/emas/apm/settings/SettingProvider;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/l$c;->c:Lcom/aliyun/emas/apm/crash/l;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/l$c;->a:Lcom/aliyun/emas/apm/crash/x0;

    iput-object p3, p0, Lcom/aliyun/emas/apm/crash/l$c;->b:Lcom/aliyun/emas/apm/settings/SettingProvider;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/l$c;->c:Lcom/aliyun/emas/apm/crash/l;

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/l$c;->a:Lcom/aliyun/emas/apm/crash/x0;

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/l$c;->b:Lcom/aliyun/emas/apm/settings/SettingProvider;

    .line 1
    invoke-static {v0, v1, v2}, Lcom/aliyun/emas/apm/crash/l;->a(Lcom/aliyun/emas/apm/crash/l;Lcom/aliyun/emas/apm/crash/x0;Lcom/aliyun/emas/apm/settings/SettingProvider;)Lcom/google/android/gms/tasks/Task;

    return-void
.end method
