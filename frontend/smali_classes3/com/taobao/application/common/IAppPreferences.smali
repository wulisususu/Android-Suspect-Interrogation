.class public interface abstract Lcom/taobao/application/common/IAppPreferences;
.super Ljava/lang/Object;
.source "IAppPreferences.java"


# static fields
.field public static final DEFAULT:Lcom/taobao/application/common/IAppPreferences;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 76
    new-instance v0, Lcom/taobao/application/common/IAppPreferences$1;

    invoke-direct {v0}, Lcom/taobao/application/common/IAppPreferences$1;-><init>()V

    sput-object v0, Lcom/taobao/application/common/IAppPreferences;->DEFAULT:Lcom/taobao/application/common/IAppPreferences;

    return-void
.end method


# virtual methods
.method public abstract getBoolean(Ljava/lang/String;Z)Z
.end method

.method public abstract getFloat(Ljava/lang/String;F)F
.end method

.method public abstract getInt(Ljava/lang/String;I)I
.end method

.method public abstract getLong(Ljava/lang/String;J)J
.end method

.method public abstract getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
.end method
