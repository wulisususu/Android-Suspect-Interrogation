.class public Lcom/taobao/agoo/a/a/a;
.super Lcom/taobao/agoo/a/a/b;
.source "Taobao"


# static fields
.field public static final INVALID_TOKEN:Ljava/lang/String; = "deprecated_alias_token_should_be_ignored"

.field public static final JSON_ALIAS_TOKEN_MAP:Ljava/lang/String; = "aliasTokenMap"

.field public static final JSON_CMD_ADDALIAS:Ljava/lang/String; = "setAlias"

.field public static final JSON_CMD_LISTALIAS:Ljava/lang/String; = "getAliasTokenMap"

.field public static final JSON_CMD_REMOVEALIAS:Ljava/lang/String; = "removeAlias"

.field public static final JSON_CMD_REMOVEALLALIAS:Ljava/lang/String; = "unbindAllAliasByDeviceId"

.field public static final JSON_CMD_REMOVEALLALIASANDADDALIAS:Ljava/lang/String; = "resetDeviceAndBindCurrentAlias"

.field public static final JSON_CMD_RESETALIASDEVICEONE2ONE:Ljava/lang/String; = "resetDeviceAndAliasToSingleBind"

.field public static final JSON_CMD_RESETAlIASANDBINDCURRENT:Ljava/lang/String; = "resetAliasAndBindCurrentDevice"


# instance fields
.field public a:Ljava/lang/String;

.field public b:Ljava/lang/String;

.field public c:Ljava/lang/String;

.field public d:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 11
    invoke-direct {p0}, Lcom/taobao/agoo/a/a/b;-><init>()V

    return-void
.end method

.method public static a(Ljava/lang/String;Ljava/lang/String;)[B
    .locals 1

    .line 126
    new-instance v0, Lcom/taobao/agoo/a/a/a;

    invoke-direct {v0}, Lcom/taobao/agoo/a/a/a;-><init>()V

    iput-object p0, v0, Lcom/taobao/agoo/a/a/a;->a:Ljava/lang/String;

    iput-object p1, v0, Lcom/taobao/agoo/a/a/a;->b:Ljava/lang/String;

    const-string p0, "unbindAllAliasByDeviceId"

    .line 129
    iput-object p0, v0, Lcom/taobao/agoo/a/a/a;->e:Ljava/lang/String;

    .line 130
    invoke-virtual {v0}, Lcom/taobao/agoo/a/a/a;->a()[B

    move-result-object p0

    return-object p0
.end method

.method public static a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)[B
    .locals 1

    .line 79
    new-instance v0, Lcom/taobao/agoo/a/a/a;

    invoke-direct {v0}, Lcom/taobao/agoo/a/a/a;-><init>()V

    iput-object p0, v0, Lcom/taobao/agoo/a/a/a;->a:Ljava/lang/String;

    iput-object p1, v0, Lcom/taobao/agoo/a/a/a;->b:Ljava/lang/String;

    iput-object p2, v0, Lcom/taobao/agoo/a/a/a;->c:Ljava/lang/String;

    const-string p0, "resetAliasAndBindCurrentDevice"

    .line 83
    iput-object p0, v0, Lcom/taobao/agoo/a/a/a;->e:Ljava/lang/String;

    .line 84
    invoke-virtual {v0}, Lcom/taobao/agoo/a/a/a;->a()[B

    move-result-object p0

    return-object p0
.end method

.method public static a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)[B
    .locals 1

    .line 109
    new-instance v0, Lcom/taobao/agoo/a/a/a;

    invoke-direct {v0}, Lcom/taobao/agoo/a/a/a;-><init>()V

    iput-object p0, v0, Lcom/taobao/agoo/a/a/a;->a:Ljava/lang/String;

    iput-object p1, v0, Lcom/taobao/agoo/a/a/a;->b:Ljava/lang/String;

    iput-object p2, v0, Lcom/taobao/agoo/a/a/a;->c:Ljava/lang/String;

    iput-object p3, v0, Lcom/taobao/agoo/a/a/a;->d:Ljava/lang/String;

    const-string p0, "removeAlias"

    .line 114
    iput-object p0, v0, Lcom/taobao/agoo/a/a/a;->e:Ljava/lang/String;

    .line 115
    invoke-virtual {v0}, Lcom/taobao/agoo/a/a/a;->a()[B

    move-result-object p0

    return-object p0
.end method

.method public static b(Ljava/lang/String;Ljava/lang/String;)[B
    .locals 1

    .line 141
    new-instance v0, Lcom/taobao/agoo/a/a/a;

    invoke-direct {v0}, Lcom/taobao/agoo/a/a/a;-><init>()V

    iput-object p0, v0, Lcom/taobao/agoo/a/a/a;->a:Ljava/lang/String;

    iput-object p1, v0, Lcom/taobao/agoo/a/a/a;->b:Ljava/lang/String;

    const-string p0, "getAliasTokenMap"

    .line 144
    iput-object p0, v0, Lcom/taobao/agoo/a/a/a;->e:Ljava/lang/String;

    .line 145
    invoke-virtual {v0}, Lcom/taobao/agoo/a/a/a;->a()[B

    move-result-object p0

    return-object p0
.end method

.method public static b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)[B
    .locals 1

    .line 88
    new-instance v0, Lcom/taobao/agoo/a/a/a;

    invoke-direct {v0}, Lcom/taobao/agoo/a/a/a;-><init>()V

    iput-object p0, v0, Lcom/taobao/agoo/a/a/a;->a:Ljava/lang/String;

    iput-object p1, v0, Lcom/taobao/agoo/a/a/a;->b:Ljava/lang/String;

    iput-object p2, v0, Lcom/taobao/agoo/a/a/a;->c:Ljava/lang/String;

    const-string p0, "setAlias"

    .line 92
    iput-object p0, v0, Lcom/taobao/agoo/a/a/a;->e:Ljava/lang/String;

    .line 93
    invoke-virtual {v0}, Lcom/taobao/agoo/a/a/a;->a()[B

    move-result-object p0

    return-object p0
.end method

.method public static c(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)[B
    .locals 1

    .line 158
    new-instance v0, Lcom/taobao/agoo/a/a/a;

    invoke-direct {v0}, Lcom/taobao/agoo/a/a/a;-><init>()V

    iput-object p0, v0, Lcom/taobao/agoo/a/a/a;->a:Ljava/lang/String;

    iput-object p1, v0, Lcom/taobao/agoo/a/a/a;->b:Ljava/lang/String;

    iput-object p2, v0, Lcom/taobao/agoo/a/a/a;->c:Ljava/lang/String;

    const-string p0, "resetDeviceAndBindCurrentAlias"

    .line 162
    iput-object p0, v0, Lcom/taobao/agoo/a/a/a;->e:Ljava/lang/String;

    .line 163
    invoke-virtual {v0}, Lcom/taobao/agoo/a/a/a;->a()[B

    move-result-object p0

    return-object p0
.end method

.method public static d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)[B
    .locals 1

    .line 176
    new-instance v0, Lcom/taobao/agoo/a/a/a;

    invoke-direct {v0}, Lcom/taobao/agoo/a/a/a;-><init>()V

    iput-object p0, v0, Lcom/taobao/agoo/a/a/a;->a:Ljava/lang/String;

    iput-object p1, v0, Lcom/taobao/agoo/a/a/a;->b:Ljava/lang/String;

    iput-object p2, v0, Lcom/taobao/agoo/a/a/a;->c:Ljava/lang/String;

    const-string p0, "resetDeviceAndAliasToSingleBind"

    .line 180
    iput-object p0, v0, Lcom/taobao/agoo/a/a/a;->e:Ljava/lang/String;

    .line 181
    invoke-virtual {v0}, Lcom/taobao/agoo/a/a/a;->a()[B

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public a()[B
    .locals 6

    const-string v0, "buildData"

    const-string v1, "AliasDO"

    const/4 v2, 0x0

    .line 62
    :try_start_0
    new-instance v3, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    invoke-direct {v3}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;-><init>()V

    const-string v4, "cmd"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/a;->e:Ljava/lang/String;

    .line 63
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    move-result-object v3

    const-string v4, "appKey"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/a;->a:Ljava/lang/String;

    .line 64
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    move-result-object v3

    const-string v4, "deviceId"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/a;->b:Ljava/lang/String;

    .line 65
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    move-result-object v3

    const-string v4, "alias"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/a;->c:Ljava/lang/String;

    .line 66
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    move-result-object v3

    const-string v4, "pushAliasToken"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/a;->d:Ljava/lang/String;

    .line 67
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    move-result-object v3

    .line 68
    invoke-virtual {v3}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->build()Lorg/json/JSONObject;

    move-result-object v3

    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    const-string v5, "data"

    aput-object v5, v4, v2

    const/4 v5, 0x1

    aput-object v3, v4, v5

    .line 69
    invoke-static {v1, v0, v4}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const-string v4, "utf-8"

    .line 70
    invoke-virtual {v3, v4}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v3

    new-array v2, v2, [Ljava/lang/Object;

    .line 72
    invoke-static {v1, v0, v3, v2}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    const/4 v0, 0x0

    :goto_0
    return-object v0
.end method
