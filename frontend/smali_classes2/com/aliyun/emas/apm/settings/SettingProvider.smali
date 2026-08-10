.class public interface abstract Lcom/aliyun/emas/apm/settings/SettingProvider;
.super Ljava/lang/Object;
.source "SourceFile"


# virtual methods
.method public abstract getSettingsAsync()Lcom/google/android/gms/tasks/Task;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/aliyun/emas/apm/settings/Settings;",
            ">;"
        }
    .end annotation
.end method

.method public abstract getSettingsSync()Lcom/aliyun/emas/apm/settings/Settings;
.end method
